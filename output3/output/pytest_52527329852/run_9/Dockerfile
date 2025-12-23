FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install OS-level dependencies
RUN apt-get update && \
    apt-get install -y python3.11 python3.11-venv python3.11-dev python3-pip curl git && \
    apt-get clean

# Set up work directory
WORKDIR /app

# Copy repository contents
COPY . .

# Set a pretend version for setuptools-scm
# Replace 'project_name' with the actual normalized distribution name
ENV SETUPTOOLS_SCM_PRETEND_VERSION_FOR_project_name=0.1.0

# Install Python dependencies
RUN python3.11 -m pip install --upgrade pip && \
    pip install tox coverage build setuptools-scm

# Copy run.sh and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set entrypoint
ENTRYPOINT ["/app/run.sh"]