# Dockerfile
FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install prerequisites
RUN apt-get update && \
    apt-get install -y software-properties-common curl && \
    apt-get clean

# Add deadsnakes PPA and install Python 3.9 and pip
RUN add-apt-repository ppa:deadsnakes/ppa && \
    apt-get update && \
    apt-get install -y python3.9 python3.9-venv python3.9-distutils && \
    apt-get clean

# Install pip for Python 3.9
RUN curl -sS https://bootstrap.pypa.io/get-pip.py | python3.9

# Set up work directory
WORKDIR /app

# Copy the repository contents
COPY . .

# Set a pretend version for setuptools-scm
ENV SETUPTOOLS_SCM_PRETEND_VERSION=0.1.0

# Install Python dependencies
RUN python3.9 -m pip install --upgrade pip && \
    python3.9 -m pip install '.[ssh,dev]'

# Copy the run.sh script and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set the entrypoint
ENTRYPOINT ["/app/run.sh"]