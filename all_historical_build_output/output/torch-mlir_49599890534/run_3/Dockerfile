# Dockerfile
FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install OS-level dependencies
RUN apt-get update && apt-get install -y \
    git \
    wget \
    build-essential \
    ccache \
    cmake \
    ninja-build \
    python3.11 \
    python3.11-venv \
    python3-pip \
    dos2unix

# Set up Python environment
RUN python3.11 -m venv /opt/mlir_venv
ENV PATH="/opt/mlir_venv/bin:$PATH"

# Create work directory
WORKDIR /workspace

# Copy repository
COPY . .

# Install Python dependencies
RUN pip install --upgrade pip
RUN pip install --pre torch-mlir torchvision \
    --extra-index-url https://download.pytorch.org/whl/nightly/cpu \
    -f https://github.com/llvm/torch-mlir-release/releases/expanded_assets/dev-wheels

# Copy run.sh and make it executable
COPY run.sh /usr/local/bin/run.sh
RUN dos2unix /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh

# Set entrypoint
ENTRYPOINT ["/usr/local/bin/run.sh"]