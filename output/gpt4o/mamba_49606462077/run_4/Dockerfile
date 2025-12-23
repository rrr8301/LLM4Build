# Dockerfile
FROM ubuntu:latest

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install dependencies including bash and dash (provides /bin/sh)
RUN apt-get update && apt-get install -y \
    bash \
    dash \
    cmake \
    ninja-build \
    g++ \
    make \
    curl \
    zsh \
    xonsh \
    fish \
    tcsh \
    python3 \
    python3-pip \
    python3-venv \
    python3-full \
    wget

# Install micromamba
RUN wget -qO- https://micromamba.snakepit.net/api/micromamba/linux-64/latest | tar -xvj bin/micromamba && \
    mv bin/micromamba /usr/local/bin/ && \
    rm -rf bin

# Create work directory
WORKDIR /app

# Copy repository
COPY . .

# Install Python packages
RUN pip install pytest

# Copy run.sh and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set entrypoint with explicit bash shell
ENTRYPOINT ["/bin/bash", "/app/run.sh"]