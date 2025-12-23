import os
import sys
import re
import yaml
import zipfile

# from utils.utils import read_log_file
import requests
import os
import git
from git import GitDB, Repo
from utils.common import log
from utils.common.credentials import GITHUB_TOKENS, OPENAI_TOKEN
import openai

PYTHON_files = ['setup.py', 'pyproject.toml', 'requirement.txt', 'Pipfile', 'Pipefile.lock', 'environment.yml', 'tox.ini', 'pytest.ini', 'setup.cfg']



def is_archive(repo, commit):
    session = requests.session()
    session.headers = {'Authorization': 'token {}'.format(GITHUB_TOKENS[0])}
    response = session.head('https://github.com/{}/commit/{}'.format(repo, commit))

    return response.status_code != 404


def is_resettable(repo, commit):
    repo_path = os.path.abspath('./intermediates/tmp/{}'.format(repo.replace('/', '-')))

    # Clone repo
    if os.path.isdir(repo_path):
        log.info('Clone of repo {} already exists.'.format(repo))

        # Explicitly set odbt, or else Repo.iter_commits fails with a broken pipe. (I don't know why.)
        # (Possibly related: https://github.com/gitpython-developers/GitPython/issues/427)
        repo_obj = Repo(repo_path, odbt=GitDB)
    else:
        log.info('Cloning repo {}'.format(repo))
        repo_obj = Repo.clone_from('https://github.com/{}'.format(repo), repo_path, odbt=GitDB)

    # Fetch refs for all pulls and PRs
    log.info('Checking if a build is resettable...')
    repo_obj.remote('origin').fetch('refs/pull/*/head:refs/remotes/origin/pr/*')

    # Get all shas
    shas = [commit.hexsha for commit in repo_obj.iter_commits(branches='', remotes='')]
    return commit in shas


def clean_log_file(log_txt):
    """
    Clean log text by removing ANSI escape sequences and timestamps.
    """
    ansi_escape = re.compile(r'''
        \x1B  # ESC
        \[    # [
        [0-?]*  # 0 or more characters from 0 to ?
        [ -/]*  # 0 or more characters from space to /
        [@-~]   # 1 character from @ to ~
    ''', re.VERBOSE)

    cleaned_log_output = ansi_escape.sub('', log_txt)

    timestamp_pattern = re.compile(r'\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}\.\d+Z\s+')

    modified_log = timestamp_pattern.sub('', cleaned_log_output)
    
    return modified_log

def ask_chatgpt(query, system_message, token, model="gpt-4.1-mini"):
    # Read the OpenAI API token from a file
    # Set up the OpenAI API key
    openai.api_key = token

    # Construct the messages for the Chat Completion API
    messages = [
        {"role": "system", "content": system_message},
        {"role": "user", "content": query}
    ]

    # Call the OpenAI API for chat completion
    response = openai.ChatCompletion.create(
        model=model,
        messages=messages,
        temperature=0
    )

    # Extract and return the content of the assistant's response
    return response["choices"][0]["message"]["content"]

    

def read_log_file(file_path):
    with open(file_path, 'r') as file:
        log = file.read()
        
    log = clean_log_file(log)
    return log

def git_clone_to_folder(project_clone_path, owner, branch, commit_sha):
    try:
        if not os.path.exists(project_clone_path):
            os.makedirs(project_clone_path)
        log.info('cloning repo... {}'.format(owner.split('/')[-1]))
        repo = git.Repo.clone_from(
            'https://github.com/{}'.format(owner), 
            '{}/{}'.format(project_clone_path, owner.split('/')[-1]), odbt=git.GitDB
        )
        log.info('cloning done')
        if branch:
            log.info(f'Checking out to the branch {branch}')
            try:
                repo.git.fetch('--all')  # Fetch all remote refs
                repo.git.checkout(branch)
                log.info(f'Checked out to branch {branch}')
            except git.exc.GitCommandError:
                log.info(f'Branch {branch} not found locally, trying to check out from origin...')
                try:
                    repo.git.checkout(f'origin/{branch}', b=branch)
                except Exception as e:
                    log.error(f'Failed to check out branch: {branch}')
                    raise e
        if commit_sha:
            log.info(f'Resetting to commit {commit_sha}')
            repo.git.reset('--hard', commit_sha)
            log.info(f'Reset to {commit_sha}')
    except Exception as e:
        log.info("Repo already cloned ")
        log.info(e)

def extract_workflow_name(file_path):
    try:
        with open(file_path, 'r') as f:
            data = yaml.safe_load(f)
            return data.get('name')  # top-level workflow name
    except Exception as e:
        print(f"Error reading {file_path}: {e}")
        return None

def read_yaml_file(file_path):
    try:
        with open(file_path, 'r') as f:
            data = yaml.safe_load(f)
            return data
    except Exception as e:
        print(f"Failed to read YAML file {file_path}: {e}")
        return None

def find_correct_yaml_file(project_clone_path, repo_name, w_name):
    yaml_files = []
    for root, dirs, files in os.walk("{}/{}".format(project_clone_path, repo_name)):
        for file in files:
            if file.endswith('.yml') or file.endswith('.yaml'):
                yaml_files.append(os.path.join(root, file))
    
    for file in yaml_files:
        workflow_name = extract_workflow_name(file)
        if str(workflow_name) == w_name:
            return file
            break
    return None

def find_readme_file(repo_path):
    try:
        for fname in os.listdir(repo_path):
            if fname.lower().startswith("readme") or fname.lower().endswith("readme"):
                full_path = os.path.join(repo_path, fname)
                if os.path.isfile(full_path):
                    return full_path
    except Exception as e:
        print(f"Error accessing {repo_path}: {e}")

    return None

def find_all_docker_files(repo_path):
    docker_files = []
    try:
        for dirpath, _, filenames in os.walk(repo_path):
            for filename in filenames:
                if 'dockerfile' in filename.lower():
                    docker_files.append(os.path.join(dirpath, filename))
    except Exception as e:
        print(f"Error accessing {repo_path}: {e}")

    return docker_files

def get_directory_structure(root_path):
    if not os.path.isdir(root_path):
        raise ValueError(f"{root_path} is not valid directory")
    
    return {os.path.basename(root_path): build_tree(root_path)}
    
def build_tree(path):
    tree = {}
    for entry in sorted(os.listdir(path)):
        full_path = os.path.join(path, entry)
        if os.path.isdir(full_path):
            tree[entry] = build_tree(full_path)
        else:
            tree[entry] = None
    return tree

def tree_to_string(tree, indent=''):
    lines = []
    total = len(tree)
    for i, (key, value) in enumerate(tree.items()):
        is_last = (i == total - 1)
        connector = '└-- ' if is_last else '|-- '
        lines.append(indent + connector + key)
        if isinstance(value, dict):
            new_indent = indent + ('    ' if is_last else '│   ')
            lines.extend(tree_to_string(value, new_indent))
    return lines

def get_directory_tree_as_string(path):
    structure = get_directory_structure(path)
    lines = tree_to_string(structure)
    return '\n'.join(lines)

def call_openai(prompt, model="gpt-4o"):
    openai.api_key = OPENAI_TOKEN
    response = openai.ChatCompletion.create(
        model=model,
        messages=[{"role": "user", "content": prompt}],
        temperature=0.0
    )
    return response['choices'][0]['message']['content']

def download_github_zip(owner: str, repo: str, commit_sha: str, output_file: str = "project_path/code.zip") -> None:
    url = f"https://github.com/{owner}/{repo}/archive/{commit_sha}.zip"
    response = requests.get(url, stream=True)

    if response.status_code != 200:
        print("no download")
        raise Exception(f"Failed to download zip: {response.status_code} {response.reason}")

    with open(output_file, "wb") as f:
        for chunk in response.iter_content(chunk_size=8192):
            f.write(chunk)

    print(f"ZIP file downloaded: {output_file}")
    
def unzip_file(zip_path: str, extract_to: str = "project_path") -> None:
    if not os.path.exists(zip_path):
        raise FileNotFoundError(f"ZIP file not found: {zip_path}")

    with zipfile.ZipFile(zip_path, 'r') as zip_ref:
        zip_ref.extractall(extract_to)
        print(f"Extracted '{zip_path}' to '{extract_to}'")



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


def find_dict_by_key(data, target_key):
    if not isinstance(data, dict):
        return None

    for key, value in data.items():
        if key == target_key and isinstance(value, dict):
            return value
        elif isinstance(value, dict):
            result = find_dict_by_key(value, target_key)
            if result:
                return result
        elif isinstance(value, list):
            for item in value:
                if isinstance(item, dict):
                    result = find_dict_by_key(item, target_key)
                    if result:
                        return result
    return None


# if __name__ == '__main__':
#     path = sys.argv[1]
#     target = sys.argv[2]
#     tree_str = get_directory_tree_as_string(path)
#     tree = get_directory_structure(path)
#     structure = get_directory_structure(path)
#     all_paths = []
#     for file in PYTHON_files:
#         full_path = find_path_in_tree(structure, file)
#         if full_path is not None:
#             all_paths.append(full_path)
            
#     full_path = find_path_in_tree(tree, target)

#     if full_path:
#         print(f"Found: {full_path}")
#     else:
#         print(f"{target} not found.")
#     print(tree_str)
#     print("\n".join(all_paths))