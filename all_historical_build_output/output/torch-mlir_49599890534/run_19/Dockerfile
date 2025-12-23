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
    python3.11-dev \
    python3-pip \
    dos2unix \
    clang \
    lld

# Set up Python environment
RUN python3.11 -m venv /opt/mlir_venv
ENV PATH="/opt/mlir_venv/bin:$PATH"

# Create work directory
WORKDIR /workspace

# Copy repository
COPY . .

# Install Python dependencies
RUN pip install --upgrade pip
RUN pip install torch torchvision \
    --extra-index-url https://download.pytorch.org/whl/nightly/cpu \
    -f https://github.com/llvm/torch-mlir-release/releases/expanded_assets/dev-wheels

# Ensure the llvm-project directory exists
RUN if [ ! -d "./externals/llvm-project" ]; then \
    mkdir -p ./externals/llvm-project && \
    git clone --depth 1 https://github.com/llvm/llvm-project.git ./externals/llvm-project; \
    fi

# Ensure the stablehlo directory exists
RUN if [ ! -d "./externals/stablehlo" ]; then \
    mkdir -p ./externals/stablehlo && \
    git clone --depth 1 https://github.com/openxla/stablehlo.git ./externals/stablehlo; \
    fi

# Copy run.sh and make it executable
COPY run.sh /usr/local/bin/run.sh
RUN dos2unix /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh

# Set entrypoint
ENTRYPOINT ["/usr/local/bin/run.sh"]