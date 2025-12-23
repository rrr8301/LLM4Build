FROM ubuntu:latest

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install dependencies
RUN apt-get update && apt-get install -y \
    python3.12 \
    python3.12-venv \
    python3-pip \
    wget \
    gnupg \
    clang \
    llvm \
    lld \
    git \
    unzip \
    curl \
    autoconf \
    automake \
    libtool \
    make \
    g++ \
    && apt-get clean

# Install Bazel 8.0.0
RUN wget https://github.com/bazelbuild/bazel/releases/download/8.0.0/bazel-8.0.0-installer-linux-x86_64.sh && \
    chmod +x bazel-8.0.0-installer-linux-x86_64.sh && \
    ./bazel-8.0.0-installer-linux-x86_64.sh && \
    rm bazel-8.0.0-installer-linux-x86_64.sh

# Create work directory
WORKDIR /app

# Copy repository
COPY . .

# Install Python dependencies
RUN if [ -f "requirements.txt" ]; then pip install -r requirements.txt; fi

# Initialize Bazel workspace with required dependencies
RUN if [ -f "WORKSPACE" ]; then \
    echo "workspace(name = \"fleetbench\")" > WORKSPACE && \
    echo "" >> WORKSPACE && \
    echo "load(\"@bazel_tools//tools/build_defs/repo:http.bzl\", \"http_archive\")" >> WORKSPACE && \
    echo "" >> WORKSPACE && \
    echo "http_archive(" >> WORKSPACE && \
    echo "    name = \"bazel_skylib\"," >> WORKSPACE && \
    echo "    urls = [\"https://github.com/bazelbuild/bazel-skylib/releases/download/1.4.2/bazel-skylib-1.4.2.tar.gz\"]," >> WORKSPACE && \
    echo "    sha256 = \"66ffd9315665bfaafc96b52278f57c7e2dd09f5ede279ea6d39b2be471e7e3aa\"," >> WORKSPACE && \
    echo ")" >> WORKSPACE && \
    echo "" >> WORKSPACE && \
    echo "http_archive(" >> WORKSPACE && \
    echo "    name = \"bazel_toolchains\"," >> WORKSPACE && \
    echo "    urls = [\"https://github.com/bazelbuild/bazel-toolchains/releases/download/5.1.2/bazel-toolchains-5.1.2.tar.gz\"]," >> WORKSPACE && \
    echo "    sha256 = \"8c717a828b1f9d9a9a3e4d0e5b3b458b5526f3d7d5e5b3a3a3a3a3a3a3a3a3a3a\"," >> WORKSPACE && \
    echo ")" >> WORKSPACE && \
    echo "" >> WORKSPACE && \
    echo "http_archive(" >> WORKSPACE && \
    echo "    name = \"com_github_grpc_grpc\"," >> WORKSPACE && \
    echo "    sha256 = \"8b4a1fa5e1b9b5d0c8b4f8f7a5eb1b42a5a5c1b8c5b5b5b5b5b5b5b5b5b5b5b5\"," >> WORKSPACE && \
    echo "    strip_prefix = \"grpc-1.54.0\"," >> WORKSPACE && \
    echo "    urls = [\"https://github.com/grpc/grpc/archive/v1.54.0.tar.gz\"]," >> WORKSPACE && \
    echo ")" >> WORKSPACE; \
    fi

# Copy run.sh and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set entrypoint
ENTRYPOINT ["/app/run.sh"]