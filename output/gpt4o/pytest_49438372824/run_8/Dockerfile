FROM ubuntu:latest

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install OS-level dependencies
RUN apt-get update && apt-get install -y \
    software-properties-common \
    python3-pip \
    && add-apt-repository -y ppa:deadsnakes/ppa \
    && apt-get update && apt-get install -y \
    python3.11 \
    python3.11-venv \
    python3.11-dev \
    python3.11-distutils \
    build-essential \
    wget \
    curl \
    git \
    && apt-get clean

# Set up work directory
WORKDIR /app

# Copy repository contents with git history
COPY . .

# Install Python packages using the system pip including setuptools-scm
RUN python3.11 -m pip install tox coverage setuptools_scm[toml]>=6.2.3 build pytest

# Create empty broken-dep-constraints.txt if it doesn't exist
RUN touch /app/broken-dep-constraints.txt

# Copy requirements file to the correct location
COPY doc/en/requirements.txt /app/requirements.txt

# Copy run.sh and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Create dist directory if it doesn't exist
RUN mkdir -p /app/dist

# Set entrypoint
ENTRYPOINT ["/app/run.sh"]