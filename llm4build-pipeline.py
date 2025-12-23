from openai import OpenAI
from together import Together
from anthropic import Anthropic

import os
import yaml
import re
import sys
import docker
import time
from markdown_it import MarkdownIt


import logging
from urllib.parse import urlparse
from utils.common import log
from utils.log_downloader import download_log
from utils.common.credentials import GITHUB_TOKENS, OPENAI_TOKEN, TOGETHER_TOKEN, CLAUDE_TOKEN
from utils.common.github_wrapper import GitHubWrapper
from Executor import Executor
from utils.utils import find_correct_yaml_file, tree_to_string, find_readme_file, git_clone_to_folder, get_directory_structure, find_path_in_tree
from utils.utils import download_github_zip, unzip_file
from job import generate_input_file, find_dict_by_key
import requests
import shutil
import json
from important_files import collect_local_action_ymls_from_content, get_repo_languages
from prompts import initial_prompt, feedback_prompt, yaml_reducer_prompt, yaml_merger, feedback_prompt_for_test
from installation_file_list import rust_installation_files, javascript_installation_files, c_cpp_installation_files, JAVA_CONFIG_FILES, python_installation_files, go_installation_files
from installation_file_list import has_tests_run
from Parsers.javaParsers import JavaMavenLogAnalyser, JavaGradleLoganalyzer
from Parsers.pythonParser import PytestLogAnalyzer, UnitTestLogAnalyzer
from Parsers.rustParser import RustLogAnalyzer, NextTestLogAnalyzer
from Parsers.c_cpp_parser import CTEST_LogAnalyzer, GTest_LogAnalyzer, GitTest_Loganalyzer
from Parsers.js_ts_parser import JestLogAnalyzer, JasmineLogAnalyzer, MochaLogAnalyzer, TypeScriptLogAnalyzer, TAPLogAnalyzer, VitestLogAnalyzer
from Parsers.go_parser import GoLogAnalyzer, GoRaceLogAnalyzer
import argparse

install_files_dict = {
    "java": JAVA_CONFIG_FILES,
    "python": python_installation_files,
    "javascript": javascript_installation_files,
    "typescript": javascript_installation_files,
    "rust": rust_installation_files,
    "go": go_installation_files,
    "c": c_cpp_installation_files,
    "c++": c_cpp_installation_files
}

def parse_url(url):
    # https://github.com/<owner>/<repo-name>/actions/runs/<run_id>
    # https://github.com/<owner>/<repo-name>/actions/runs/<run_id>/jobs/<job_id>
    # pattern = r'https://github.com/([^/]+/[^/]+)/actions/runs/(\d+)(?:/jobs/(\d+))?'
    match = re.match(r'https://github.com/([^/]+/[^/]+)/actions/runs/(\d+)(?:/job/(\d+))?', url)
    if match:
        return match.group(1), match.group(2), match.group(3)
    return None, None, None

def get_job_json(repo, run_id, job_id):
    github_wrapper = GitHubWrapper(GITHUB_TOKENS)
    status, json_data = github_wrapper.get('https://api.github.com/repos/{}/actions/runs/{}/jobs'.format(repo, run_id))
    
    if status is None or not status.ok:
        log.error('Invalid GitHub Actions URL')
        return {}
    
    jobs = json_data['jobs']
    
    for job in jobs:
        if int(job['id']) == int(job_id):
            print("match")
            return job
            break
        
    return {}

def extract_dockerfile_and_script(text):
    dockerfile_pattern = re.compile(r"```Dockerfile(.*?)```", re.DOTALL | re.IGNORECASE)
    bash_script_pattern = re.compile(r"```bash(.*?)```", re.DOTALL | re.IGNORECASE)

    dockerfile_match = dockerfile_pattern.search(text)
    bash_script_match = bash_script_pattern.search(text)

    dockerfile_content = dockerfile_match.group(1).strip() if dockerfile_match else None
    bash_script_content = bash_script_match.group(1).strip() if bash_script_match else None

    return dockerfile_content, bash_script_content

# def run_pipeline():
def get_directory_tree_as_string(path):
    structure = get_directory_structure(path)
    lines = tree_to_string(structure)
    return '\n'.join(lines)

def find_path_in_tree(tree, target_name, current_path=""):
    """Recursively search the tree for the target and return its full path."""
    for name, subtree in tree.items():
        new_path = os.path.join(current_path, name)

        if name == target_name:
            return new_path

        if isinstance(subtree, dict):
            result = find_path_in_tree(subtree, target_name, new_path)
            if result:
                return result

    return None

def call_openai(prompt, model="gpt-4o"):
    client = OpenAI(api_key=OPENAI_TOKEN)  # prefer this var name
    resp = client.chat.completions.create(
        model=model,
        messages=[{"role": "user", "content": prompt}],
        temperature=0.0,
    )
    return resp.choices[0].message.content


def get_source_info_from_run(owner: str, repo: str, run_id: str, github_token: str):
    """
    Returns the source repo and branch for a GitHub Actions run, whether it's from a PR or direct push.
    """
    url = f"https://api.github.com/repos/{owner}/{repo}/actions/runs/{run_id}"
    headers = {"Authorization": f"Bearer {github_token}"}
    
    resp = requests.get(url, headers=headers)
    resp.raise_for_status()
    data = resp.json()

    return data["head_repository"]["full_name"]


def has_local_uses(yaml_content: str) -> bool:
    """
    Return True if any 'uses:' line refers to a local/.repo path containing '/.github/'.
    Handles lines like:
      - uses: ./.github/actions/foo
      - uses: repo/.github/actions/bar
    """
    pattern = re.compile(
        r'^\s*(?:-\s*)?uses:\s*[^#\n]*/\.github/',  # allow leading "- ", then any path with "/.github/"
        re.IGNORECASE | re.MULTILINE
    )
    return bool(pattern.search(yaml_content))

def extract_intra_repo_links(text):
    md = MarkdownIt()
    tokens = md.parse(text)

    urls = []

    # --- A) Markdown links + images ---
    for token in tokens:
        # standard links: [text](href)
        if token.type == "inline" and token.children:
            for child in token.children:
                if child.type == "link_open":
                    href = child.attrs.get("href")
                    if href:
                        urls.append(href)
                # images: ![alt](src)
                if child.type == "image":
                    src = child.attrs.get("src")
                    if src:
                        urls.append(src)

    # --- B) reStructuredText image blocks + :target: ---
    # Matches:
    # .. image:: <URL-or-path>
    #    :target: <URL-or-path>
    # (target is optional; we capture both)
    img_block_re = re.compile(
        r"^\.\.\s+image::\s+(\S+)\s*$"
        r"(?:[\r\n]+[ \t]*:target:\s*(\S+))?",
        re.MULTILINE
    )
    for m in img_block_re.finditer(text):
        img_url, target_url = m.group(1), m.group(2)
        urls.append(img_url)
        if target_url:
            urls.append(target_url)

    # --- Post-process into intra-repo paths like your original logic ---
    intra_repo = set()
    for link in urls:
        link = link.split('#')[0].strip()
        if not link:
            continue

        # Case 1: relative paths (e.g., CONTRIBUTING.md)
        if not re.match(r'^https?://', link):
            intra_repo.add(link)
            continue

        parsed = urlparse(link)
        host = parsed.netloc.lower()

        # Accept github.com and www.github.com
        if host.endswith("github.com"):
            path = parsed.path

            # /blob/ style links → extract path after /blob/
            if "/blob/" in path:
                intra_repo.add(path.split("/blob/", 1)[-1])
                continue

            # /actions/workflows/*.yml|yaml (badges often point here via :target:)
            if "/actions/workflows/" in path:
                filename = path.split("/actions/workflows/", 1)[-1]
                # normalize to repo path
                if filename.endswith((".yml", ".yaml")):
                    intra_repo.add(f".github/workflows/{filename}")
                else:
                    # badge .svg or others → try to strip the trailing /badge.svg
                    if filename.endswith("/badge.svg"):
                        filename = filename[:-len("/badge.svg")]
                    if filename.endswith((".yml", ".yaml")):
                        intra_repo.add(f".github/workflows/{filename}")

    return sorted(intra_repo)
                        
def filter_test_ymls(yml_dict, keywords=("test", "build", "ci")):
    filtered = {}
    for yml_file, name in yml_dict.items():
        combined = f"{yml_file} {name}".lower()
        if any(keyword.lower() in combined for keyword in keywords):
            filtered[yml_file] = name
    return filtered


def list_yml_names(project_path, workflows_dir=".github/workflows"):
    yml_to_name = {}
    
    full_path = os.path.join(project_path, workflows_dir)
    if not os.path.exists(full_path):
        return {}

    for filename in os.listdir(full_path):
        if filename.endswith(".yml") or filename.endswith(".yaml"):
            filepath = os.path.join(full_path, filename)
            try:
                with open(filepath, "r") as f:
                    data = yaml.safe_load(f)
                    name = data.get("name", "Unnamed Workflow")
                    yml_to_name[filename] = name
            except Exception as e:
                yml_to_name[filename] = f"Error: {e}"

    return yml_to_name

def list_yml_names_given(project_path, yml_path):
    yml_to_name = {}
    
    full_path = os.path.join(project_path, yml_path)
    if not os.path.exists(full_path):
        return {}

    # for filename in os.listdir(full_path):
    if full_path.endswith(".yml") or full_path.endswith(".yaml"):
        # filepath = os.path.join(full_path, full_path)
        try:
            with open(full_path, "r") as f:
                data = yaml.safe_load(f)
                name = data.get("name", "Unnamed Workflow")
                yml_to_name[full_path] = name
        except Exception as e:
            yml_to_name[full_path] = f"Error: {e}"

    return yml_to_name

def call_openai(prompt, model="gpt-4o"):
    client = OpenAI(api_key=OPENAI_TOKEN)  # prefer this var name
    resp = client.chat.completions.create(
        model=model,
        messages=[{"role": "user", "content": prompt}],
        temperature=0.0,
    )
    return resp.choices[0].message.content


def call_together(prompt, model="deepseek-ai/DeepSeek-V3"):
    client = Together(api_key=TOGETHER_TOKEN)
    resp = client.chat.completions.create(
        model=model,
        messages=[{"role": "user", "content": prompt}],
        temperature=0.0,
    )
    return resp.choices[0].message.content


def call_claude(prompt, model="claude-3.7-sonnet-20250219"):
    client = Anthropic(api_key=CLAUDE_TOKEN)

    resp = client.messages.create(
        model=model,
        max_tokens=4096,
        temperature=0.0,
        messages=[
            {"role": "user", "content": prompt}
        ]
    )

    # Claude returns a list of content blocks
    return resp.content[0].text

def is_github_repo(url: str) -> bool:
    url = url.strip()
    https_pat = re.compile(r'^https?://github\.com/[^/]+/[^/]+(?:\.git)?/?$')
    ssh_pat   = re.compile(r'^git@github\.com:[^/]+/[^/]+(?:\.git)?$')
    return bool(https_pat.match(url) or ssh_pat.match(url))

def copy_contents(src_dir, dst_dir):
    os.makedirs(dst_dir, exist_ok=True)

    for item in os.listdir(src_dir):
        s = os.path.join(src_dir, item)
        d = os.path.join(dst_dir, item)

        if os.path.isdir(s):
            shutil.copytree(s, d, dirs_exist_ok=True)  # copy subdirectory
        else:
            shutil.copy2(s, d)  # copy file

def detect_analyzer(log_lines):
    analyzers = [
        JavaMavenLogAnalyser,
        JavaGradleLoganalyzer,
        PytestLogAnalyzer,
        UnitTestLogAnalyzer,
        RustLogAnalyzer,
        NextTestLogAnalyzer,
        JasmineLogAnalyzer,
        JestLogAnalyzer,
        MochaLogAnalyzer,
        CTEST_LogAnalyzer,
        GTest_LogAnalyzer,
        VitestLogAnalyzer,
        TAPLogAnalyzer,
        TypeScriptLogAnalyzer,
        GoLogAnalyzer,
        GoRaceLogAnalyzer
    ]
    
    applicable = []
    for AnalyzerClass in analyzers:
        analyzer = AnalyzerClass(log_lines)
        if analyzer.is_applicable():
            applicable.append(analyzer)
    
    if not applicable:
        return None
    
    # For now, we'll just return the first match. Since there can be only one unique ?
    return applicable

def latest_dir(path):
    # Full paths of only directories
    dirs = [
        os.path.join(path, d)
        for d in os.listdir(path)
        if os.path.isdir(os.path.join(path, d))
    ]
    if not dirs:
        return None

    # Sort by creation time (newest last)
    latest = max(dirs, key=os.path.getctime)
    return latest

def read_log_file(file_path):
    with open(file_path, 'r', encoding='utf-8') as file:
        return file.readlines()

def parse_args():
    p = argparse.ArgumentParser()
    p.add_argument('--task', help='task type')
    p.add_argument('--link',
                   help='Ignore the repo blacklist, collecting all repos that match the query instead.')
    p.add_argument('--model',
                   help='provide the model name')
    p.add_argument("--output_folder", 
                   help="provide output folder")
    # p.add_argument('-t', '--token',
    #                help='The GitHub token to make requests with. Defaults to the first entry in '
    #                     '`bugswarm.common.credentials.GITHUB_TOKENS`.')
    return p.parse_args()

    
def main():
    log.config_logging(getattr(logging, 'INFO', None))
    args = parse_args()
    task = args.task
    link = args.link
    model = args.model
    output_folder = args.output_folder
    if task == 'latest_build':
        repo_link = args.link
        repo_link_parts = repo_link.split("/")
        owner = repo_link_parts[-2]
        repo_name = repo_link_parts[-1].split(".")[0]
        
        # clone the repository
        project_clone_path = "project_path"
        git_clone_to_folder(project_clone_path, f"{owner}/{repo_name}", None, None)
        # get the workflow file
        project_path = os.path.join(project_clone_path, repo_name)
        readme_path = find_readme_file(project_path)
        
        with open(readme_path, "r") as r_file:
            readme_content = r_file.read()
        
        links = extract_intra_repo_links(readme_content)
        print("links",links, project_path)
        yaml_files = []
        for l in links:
            if l.endswith('yml') or l.endswith('yaml'):
                if os.path.exists(os.path.join(project_path, l)):
                    yaml_files.append(l)
        
        print(yaml_files)
        yml_paths = []
        if len(yaml_files) > 0:
            yml_to_name = []
            workflow_name = []
            for y in yaml_files:
                k = list_yml_names_given(project_path, y)
                yml_to_name.append(k)
                workflow_name.append(list(k.values())[0])
                yml_paths.append(list(k.keys())[0])
        yaml_file_dict = list_yml_names(project_path, workflows_dir=".github/workflows")
        yaml_file_dict_filtered = filter_test_ymls(yaml_file_dict, keywords=("test", "build", "ci", "linux", "main"))
        yaml_files = list(yaml_file_dict_filtered.keys())
        for y in yaml_files:
            yaml_path = os.path.join("project_path", repo_name, ".github/workflows", y)
            yml_paths.append(yaml_path)
        yml_content = []
        for yml in yml_paths:
            with open(yml, 'r') as file:
                content = file.read()
            yml_content.append(content)
        
        new_yml_content = set(yml_content)
        new_yml_set_to_add = set(yml_content)
        for cont in new_yml_content:
            # print("local uses ", has_local_uses(cont))
            if has_local_uses(cont):
                new_dict = collect_local_action_ymls_from_content(project_path, cont)
                # local_files_list = list(new_dict.keys())
                for k, v in new_dict.items():
                    new_yml_set_to_add.add(v)
        yaml_content = list(new_yml_set_to_add)
        # print("jjjj ", yaml_content)  
        if model == "gpt-4o":      
            yaml_output = call_openai(yaml_merger(yaml_content))
        else:
            yaml_output = call_together(yaml_merger(yaml_content))
        # print(yaml_output)
        yaml_pattern = re.compile(r"```yaml(.*?)```", re.DOTALL | re.IGNORECASE)
        yaml_match = yaml_pattern.search(yaml_output)
        yaml_file_content = yaml_match.group(1).strip() if yaml_match else None
        repo_path = f"project_path/{repo_name}/"
        image_name = f"{repo_name.lower()}_main:latest"
    else:
        repo, run_id, job_id = parse_url(args.link)
        print(repo)
        print(run_id)
        print(job_id)
        if repo is None:
            log.error('This is not a valid GitHub Actions URL.')
            return 1
        job = get_job_json(repo, run_id, job_id)
        print("job ", job)
        job_name = job["workflow_name"]
        job_name_specific = job["name"]
        print(repo)
        project = repo.split("/")[-1]
        owner = repo.split("/")[0]
        repo_name = project
        print(project)
        print(owner)
        download_log(job_id, 'original_logs/{}-{}.log'.format(project ,job_id), repo=repo)
            
        download_github_zip(owner, project, job['head_sha'])
        unzip_file("project_path/code.zip")
            # get the workflow file
        project_clone_path = "project_path"
        project_path = os.path.join(project_clone_path, f"{project}-{job['head_sha']}")
        correct_yaml_file = find_correct_yaml_file(project_clone_path, f"{project}-{job['head_sha']}", job_name)
        print("correct ", correct_yaml_file)
        with open(correct_yaml_file, "r") as f:
            yaml_content = f.read()
            
        read_me = find_readme_file(project_path)
        with open(read_me, "r") as file:
            readme_content = file.read()
            
        json_file = generate_input_file(repo, job_id, None)
        p = json_file['failed_build']['jobs'][0]['config']
        q = json_file['passed_build']['jobs'][0]['config']
        mat_p = find_dict_by_key(q, "matrix")
        mat_q = find_dict_by_key(p, "matrix")
            
        mat_k = {}
        if mat_p is not None:
            mat_k = mat_p
        elif mat_q is not None:
            mat_k = mat_q
            
        if model == "gpt-4o":
            yaml_output = call_openai(yaml_reducer_prompt(yaml_content, job_name_specific, mat_k))
        else:
            yaml_output = call_together(yaml_reducer_prompt(yaml_content, job_name_specific, mat_k))
        print("yyy\n", yaml_output)
        yaml_pattern = re.compile(r"```(yamlfile|yaml)(.*?)```", re.DOTALL | re.IGNORECASE)
        yaml_match = yaml_pattern.search(yaml_output)
        yaml_content = yaml_match.group(2).strip() if yaml_match else None
        print(yaml_content)
            
        if yaml_content is None:
            exit(1)
                
        local_uses = has_local_uses(yaml_content)
        print("llll ",local_uses)
        content = yaml_content
        if local_uses:
            new_dict = collect_local_action_ymls_from_content(project_path, yaml_content)
            # local_files_list = list(new_dict.keys())
            for k, v in new_dict.items():
                content = content + f"\n=== {k} ===\n{v}\n"
            # else:
            #     content = yaml_content
            
        print(content)
        yaml_file_content = content
        os.remove("project_path/code.zip")
        repo_path = f"project_path/{project}-{job["head_sha"]}/"
        image_name = "{}_{}".format(project.lower(), job_id)
            # tree_str = get_directory_tree_as_string(repo_path)
            # tree = get_directory_structure(repo_path)
    language_list = list(install_files_dict.keys())
    lang_metadata = get_repo_languages(owner, repo_name)
    languages = lang_metadata["languages"]
    langs = []
    for l in languages:
        if l['name'].lower() in language_list:
            langs.append(l['name'].lower())
    
    installation_files = []
    for k in langs:
        installation_files += install_files_dict[k]
    installation_files = list(set(installation_files))
    print("image name ", image_name)
    structure = get_directory_structure(repo_path)
    all_paths = []
    for file in installation_files:
        full_path = find_path_in_tree(structure, file)
        if full_path is not None:
            all_paths.append(full_path)

    path_string = "\n".join(all_paths)
    max_retries = 20
    if args.task == "historical_build":
        ext = str(job_id)
    else:
        ext = "master"
    for attempt in range(max_retries):
        print(f"\nAttempt {attempt}...")
            
        if attempt == 0:
            if model == "gpt-4o":
                result = call_openai(initial_prompt(yaml_file_content, readme_content) + f"\nImportant installation filepath\n{path_string}\n")
            else:
                result = call_together(initial_prompt(yaml_file_content, readme_content) + f"\nImportant installation filepath\n{path_string}\n")
        else:
            print(attempt)
            print("error prompt \n")
            print(error_prompt)
            if model == "gpr-4o":
                result = call_openai(error_prompt + f"\nImportant installation filepath\n{path_string}\n")
            else:
                result = call_together(error_prompt + f"\nImportant installation filepath\n{path_string}\n")
        
        # output_directory = args.output_folder
        if model == "gpt-4o":
            output_ = os.path.join(output_folder, 'gpt4o')
        elif model == "deepseek-ai/DeepSeek-V3":
            output_ = os.path.join(output_folder, 'deepseekV3')
        dockerfile_content, bash_content = extract_dockerfile_and_script(result)
        output_path = os.path.join(output_, "{}_{}".format(repo_name, ext), "run_{}".format(str(attempt)))
        if not os.path.exists(output_path):
            os.makedirs(output_path)
        dockerfile_path = os.path.join(output_path, "Dockerfile")
        bashscript_path = os.path.join(output_path, "run.sh")
        log_path = os.path.join(output_path, "log.txt")
        docker_log_path = os.path.join(output_path, "docker_log.txt")
            
        with open(dockerfile_path, 'w') as f1:
            f1.write(dockerfile_content)
                
        with open(bashscript_path, 'w') as f2:
            f2.write(bash_content)
        
            # Executor
            # executes all the commands - docker image, test executions
        executor = Executor(dockerfile_path, bashscript_path, log_path, project_path, docker_log_path)
        build_info = executor.execute(image_name)
            
        error_prompt = ""
            
        if build_info["success"] == False:
            # make prompt
            #error_sts = build_info["error_log"].split('\n')
            error_msg = "Error from docker\n" + build_info["error_log"]
            print("Error message: ")
            print(error_msg)
            if args.task == "historical_build":
                error_prompt = feedback_prompt(dockerfile_content, bash_content, error_msg, yaml_file_content)
            else:
                error_prompt = feedback_prompt_for_test(dockerfile_content, bash_content, error_msg)
        else:
            client = docker.from_env()
            log_lines = []

            try:
                print(f"Running container from image: {image_name}")
                container = client.containers.run(
                    image=image_name,
                    detach=True,
                    stdout=True,
                    stderr=True,
                    remove=False  # Don't auto-remove so we can inspect on failure
                )

                logs = container.logs(stream=True, stdout=True, stderr=True)
                with open(log_path, "w") as f:
                    for line in logs:
                        decoded = line.decode(errors="replace").rstrip()
                        print(decoded)
                        f.write(decoded + "\n")
                        log_lines.append(decoded)

                    # Ensure container is stopped and removed
                exit_status = container.wait()
                container.remove()

                success = (exit_status.get("StatusCode", 1) == 0)
                if success == True:
                    if has_tests_run(log_lines):
                        break
                    else:
                        log_ = log_lines[-80:]
                        log_text = "\n".join(log_)
                        log_text = "The Tests have not been run\nError from run.sh\n" + log_text
                        if args.task == "historical_build":
                            error_prompt = feedback_prompt(dockerfile_content, bash_content, log_text, yaml_file_content)
                        else:
                            error_prompt = feedback_prompt_for_test(dockerfile_content, bash_content, log_text)
                else:
                    if has_tests_run(log_lines):
                        break
                    log_ = log_lines[-80:]
                    log_text = "\n".join(log_)
                    log_text = "Error from run.sh\n" + log_text
                    if args.task == "historical_build":
                        error_prompt = feedback_prompt(dockerfile_content, bash_content, log_text, yaml_file_content)
                    else:
                        error_prompt = feedback_prompt_for_test(dockerfile_content, bash_content, log_text)
            except docker.errors.ContainerError as e:
                # Still return logs if captured
                print("Error")
                log_ = log_lines[-30:]
                log_text = "\n".join(log_)
                with open(log_path, "w") as f:
                    f.write(log_text + "\n")
                log_text = "Error from run.sh\n" + log_text
                if args.task == "historical_build":
                    error_prompt = feedback_prompt(dockerfile_content, bash_content, error_msg, yaml_file_content)
                else:
                    error_prompt = feedback_prompt_for_test(dockerfile_content, bash_content, error_msg)
    
                    
    output_dir = os.path.join(output_, "{}_{}".format(repo_name, ext))
    output_path = latest_dir(output_dir)
    src_path = output_path
    dst_path = os.path.join(output_dir, "out")
    print(src_path, dst_path)
    copy_contents(src_path, dst_path)
    output_log = os.path.join(output_, "{}_{}".format(repo_name, ext), "out", "log.txt")
    log_lines = read_log_file(output_log)
    
    analyzer = detect_analyzer(log_lines)
    if analyzer:
        results_list = []
        for a in analyzer:
            results = a.analyze()
            results_list.append(results)
        output_json_path = os.path.join(output_, "{}_{}".format(repo_name, ext), "out", "out.json")
        with open(output_json_path, "w") as f:
            json.dump(results_list, f, indent=2)
        
    
if __name__ == '__main__':
    start_time = time.time()

    exit_code = main()

    end_time = time.time()
    elapsed_time = end_time - start_time

    print(f"Execution time: {elapsed_time:.2f} seconds")
    sys.exit(exit_code)         

# def main():
#     return