# Dockerfile
FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install OS-level dependencies
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    build-essential \
    make \
    git \
    && rm -rf /var/lib/apt/lists/*

# Set the working directory
WORKDIR /app

# Copy the repository contents into the container
COPY . .

# Set a pretend version for setuptools-scm
ENV SETUPTOOLS_SCM_PRETEND_VERSION=0.1.0

# Install Python dependencies
RUN python3 -m pip install --upgrade pip
RUN pip3 install '.[ssh,dev]' build pytest pytest-cov

# Copy the run.sh script and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set the entrypoint to run.sh
ENTRYPOINT ["/app/run.sh"]