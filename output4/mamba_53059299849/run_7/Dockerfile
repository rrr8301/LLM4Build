FROM ubuntu:latest

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install dependencies
RUN apt-get update && apt-get install -y \
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
    git \
    libyaml-dev \
    build-essential \
    libfmt-dev \
    libspdlog-dev \
    libboost-all-dev \
    wget \
    unzip

# Install tl-expected
RUN mkdir -p /tmp/tl-expected && \
    cd /tmp/tl-expected && \
    wget https://github.com/TartanLlama/expected/archive/refs/tags/v1.0.0.zip && \
    unzip v1.0.0.zip && \
    cd expected-1.0.0 && \
    mkdir build && \
    cd build && \
    cmake .. && \
    make && \
    make install && \
    cd / && \
    rm -rf /tmp/tl-expected

# Create work directory
WORKDIR /app

# Copy repository
COPY . .

# Create a virtual environment and install Python dependencies
RUN python3 -m venv /app/venv
RUN /app/venv/bin/pip install --upgrade pip
RUN /app/venv/bin/pip install pytest PyYAML mypy

# Copy run.sh and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set entrypoint
ENTRYPOINT ["/app/run.sh"]