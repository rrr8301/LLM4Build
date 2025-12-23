# Prompt for initial CoT reasoning and generation
def initial_prompt(yaml_content, readme_content):
    return f"""You are a DevOps engineer tasked with converting a GitHub Actions job into a Dockerfile and a bash script (`run.sh`). You will first reason step-by-step through the job's requirements and environment, and then generate the scripts.
You need to build the repository at first. The yaml file or files related to the job will also be given here to get help.

Follow these steps:

1. Parse the job configuration: Identify the job name, `runs-on` OS, language setup (e.g., Python, Java), matrix (if any), and key steps.
2. Infer the base image: Choose a suitable base image (e.g., `ubuntu`, `nvidia/cuda` if GPU job). Base it on `runs-on` or job purpose.
3. Determine the language and version: Extract this from the job (e.g., `setup-python@v5`) or fallback to the README or config files.
4. Identify required packages:
     i. Extract `apt`, `brew`, or other OS-level packages from setup steps or install commands.
    ii. Identify `pip`, `npm`, `gem`, `go`, or other language-specific packages.
   iii. Include extra build tools like `cmake`, `ninja`, `g++`, `make`, `conda`, `playwrite`, `clang`, `cargo`, `git` etc.
   iv. include testing packages like `uv`, `pytest`, `maven` etc
5. Handle unsupported actions:
     i. Ignore or remove GitHub-specific actions such as `actions/cache`, `actions/download-artifact`, `actions/upload-artifact`, etc.
    ii. Provide brief explanations or runtime alternatives if necessary.
   iii. List of unsupported github actions
        - actions/cache
        - actions/download-artifact
        - actions/upload-artifact
        - codecov/codecov-action@v5
        - Mozilla-Actions/sccache-action
6. Handle or ignore secret variables. Focus on test execution related workflow only
7. Resolve artifacts:
   i. Simulate or make assumptions for downloaded wheels/binaries.
8. Write the Dockerfile:
   - Use base image
   - Set TZ to Pacific Time (America/Los_Angeles) automatically and noninteractively so no tzdata prompts appear during build
   - Install dependencies
   - Create work directory
   - Copy repo
   - Install packages
   - Include alternatives for the unsupported actions (if any)
   - Copy run.sh, make it executable and set as entrypoint (provide full path of run.sh)
9. Write the run.sh:
   - start with `#!/bin/bash`, do not start with `# run.sh`
   - Activate envs
   - Install project deps
   - Run tests
   - Ensure that all test cases are executed, even if some fail. Do not let test failures skip the rest of the test suite.
10. Use placeholders when needed.

Format:

Dockerfile
```Dockerfile
<your Dockerfile>
```

run.sh
```bash
<your run.sh>
```

---YAML---
{yaml_content}

---README---
{readme_content}
"""


# Prompt for feedback-based revision
def feedback_prompt(dockerfile, run_script, error_log, yaml):
    return f"""You generated the following Dockerfile and run.sh, but they failed to execute due to the error log given below.

---Dockerfile---
```Dockerfile
{dockerfile}
```

---run.sh---
```bash
{run_script}
```

---Execution Error Log: ---
```
{error_log}
```

--YAML--
{yaml}

Please revise necessary scripts to fix the issue according to the error log. 
Error log will tell from which scripts error produces. Please modify necessary 
scripts to run all the test cases. Do not skip any remaining tests. Always keep 
enforcer skipping flag and license skipping flag if it was added earlier, do not 
try to remove those. 

Do not change or replace any runtime or language version (e.g., Python, Java, 
Node, Go, Rust, etc.) specified in the job name, matrix, or configuration. For 
example, if the configuration requires python3.14, JDK 17, or Node 20, you must 
keep exactly those versions. You may add supporting packages or flags, but the 
versions of core runtimes must remain unchanged. Please skip those test files
which are mentioned to be skipped in the yaml file

Dockerfile
```Dockerfile
<revised>
```

run.sh
```bash
<revised>
```
"""

def yaml_reducer_prompt(yaml_content, matrix, job_name):
    return f"""Your task is to generate a yaml  from a given yml script. You will be given job name and other matrices. Your will 
build yaml script based on the job name and matrices. Please do not include other jobs as we will consider the given 
particular job. If matrix is unavailable or empty dict, please consider it from the name of the job(if there is any 
descriptive name).
    
    YAML file
    ```yamlfile
    <your reduced yamlfile>
    ```

    ---YAML---
    {yaml_content}

    ---Job name---
    {job_name}
    
    ---Matrix---
    {matrix}
"""


def yaml_merger(yaml_content_list):
    yaml_content = ""
    
    for yaml in yaml_content_list:
        yaml_content = yaml_content + '\n' + yaml
    
    return f"""You are an expert CI/CD engineer. Given a GitHub Actions workflow YAML, your task is to simplify it into 
a minimal form. The reduced workflow must contain only a single job that runs on ubuntu-22.04 with one stable language 
version (for example, Python 3.12, Node 20, or JDK 17). Remove all matrix strategies, extra OS targets, and dependency 
variants. The job should set up the chosen runtime, install dependencies in the simplest way (such as pip install, npm ci, 
mvn install), build the repository, build the repository and then run all available test types (unit, integration, smoke, and end-to-end) 
together using the project’s default test runner. Try to keep the command same as the original yaml file. If the original workflow includes coverage or artifact upload steps 
(e.g., Codecov, JUnit reports, coverage.xml), preserve them; otherwise, skip extras. Return only the final, valid GitHub 
Actions YAML file without any explanations or commentary.
    
    YAML file
    ```yamlfile
    <your merged yamlfile>
    ```

    ---YAML Files---
    {yaml_content}
    """

def initial_prompt_for_cfg(build_cmds, install_cmds, test_cmds, language):
    return f"""You are tasked with writing a dockerfile and bash script by giving a list of build, install and test commands. You will first 
reason step by step by the commands and generate the script so that the scripts will build the repository at first successfully and test it. 

Follow the steps
1. Infer the base image. Choose ubuntu-22.04
2. Separate the commands according to the language and which is necessary for building the repo, installing package and executes tests.
3. Identify required packages from the commands:
    i. Extract `apt`, or other OS-level packages from setup steps or install commands.
    ii. Identify `pip`, `npm`, `gem`, `go`, or other language-specific packages.
    iii. Include extra build tools like `cmake`, `ninja`, `g++`, `make`, `conda`, `playwrite`, `clang`, `cargo` etc.
4. Write the Dockerfile:
- Use base image
- Set TZ to Pacific Time (America/Los_Angeles) automatically and noninteractively so no tzdata prompts appear during build
- Install dependencies
- Create work directory
- Copy repo
- Install packages
- Include alternatives for the unsupported actions (if any)
- Copy run.sh, make it executable and set as entrypoint (provide full path of run.sh)
5. Write the run.sh:
- Activate envs
- Install project deps
- Add license headers if necessary
- Run tests
- Ensure that all test cases are executed, even if some fail. Do not let test failures skip the rest of the test suite.


Format:

Dockerfile
```Dockerfile
<your Dockerfile>
```

run.sh
```bash
<your run.sh>
```

---Build commands---
{build_cmds}

---Install commands---
{install_cmds}

---Test Commands---
{test_cmds}

---language---
{language}

"""

def feedback_prompt_for_test(dockerfile, run_script, error_log):
    return f"""You generated the following Dockerfile and run.sh, but they failed to execute due to the error log given below.

---Dockerfile---
```Dockerfile
{dockerfile}
```

---run.sh---
```bash
{run_script}
```

---Execution Error Log: ---
```
{error_log}
```

Please revise necessary scripts to fix the issue according to the error log. 
Error log will tell from which scripts error produces. Please modify necessary 
scripts to run all the test cases. Do not skip any remaining tests. Always keep 
enforcer skipping flag and license skipping flag if it was added earlier, do not 
try to remove those. 

Dockerfile
```Dockerfile
<revised>
```

run.sh
```bash
<revised>
```
"""