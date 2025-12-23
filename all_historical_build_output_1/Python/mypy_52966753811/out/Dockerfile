# Dockerfile
FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install OS-level dependencies
RUN apt-get update && apt-get install -y \
    clang \
    build-essential \
    curl \
    git \
    libssl-dev \
    zlib1g-dev \
    libbz2-dev \
    libreadline-dev \
    libsqlite3-dev \
    wget \
    llvm \
    libncurses5-dev \
    libncursesw5-dev \
    xz-utils \
    tk-dev \
    libffi-dev \
    liblzma-dev \
    && apt-get clean

# Install pyenv
RUN curl https://pyenv.run | bash

# Set environment variables for pyenv
ENV PATH="/root/.pyenv/bin:/root/.pyenv/shims:${PATH}"
RUN echo 'eval "$(pyenv init --path)"' >> ~/.bashrc

# Install Python 3.13 using pyenv
RUN pyenv install 3.13-dev && pyenv global 3.13-dev

# Install pip
RUN curl -sS https://bootstrap.pypa.io/get-pip.py | python3.13

# Set work directory
WORKDIR /app

# Copy repository files
COPY . .

# Install Python dependencies
RUN pip install setuptools==75.1.0 tox==4.26.0

# Copy and set permissions for run.sh
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set entrypoint
ENTRYPOINT ["/app/run.sh"]