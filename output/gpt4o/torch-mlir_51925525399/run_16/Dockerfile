FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    software-properties-common \
    gnupg2 \
    ca-certificates \
    cmake \
    build-essential \
    && apt-key adv --keyserver keyserver.ubuntu.com --recv-keys F23C5A6CF475977595C89F51BA6932366A755776 \
    && add-apt-repository -y ppa:deadsnakes/ppa \
    && apt-get update && apt-get install -y \
    python3.11 \
    python3.11-venv \
    python3-pip \
    ccache \
    ninja-build \
    git \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Set up Python environment
RUN python3.11 -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

# Create work directory
WORKDIR /app

# Copy repository and initialize submodules
# First copy just the files needed for submodule initialization
COPY .gitmodules .
COPY .git/config .git/config
RUN mkdir -p .git/modules && \
    git submodule update --init --recursive

# Now copy the rest of the repository
COPY . .

# Make scripts executable
RUN chmod +x build_tools/ci/install_python_deps.sh \
    && chmod +x build_tools/ci/build_posix.sh \
    && chmod +x build_tools/ci/test_posix.sh \
    && chmod +x build_tools/ci/check_generated_sources.sh

# Install build dependencies first
RUN pip install --upgrade pip && \
    pip install numpy packaging && \
    pip install -f https://llvm.github.io/torch-mlir/package-index/ torch-mlir --no-deps && \
    mkdir -p torch_mlir/_mlir_libs

# Build and install torch-mlir
RUN pip install . --no-build-isolation && \
    pip install -e . --no-build-isolation

# Copy run.sh and make it executable
COPY run.sh /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh

# Set entrypoint
ENTRYPOINT ["/usr/local/bin/run.sh"]