FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive
ENV LANG=C.UTF-8
ENV LC_ALL=C.UTF-8
ENV PATH="/root/.cargo/bin:/usr/local/bin:$PATH"

# Enable universe repository correctly and update apt sources
RUN apt-get update && apt-get install -y software-properties-common \
    && add-apt-repository universe \
    && apt-get update && apt-get install -y --no-install-recommends \
    curl \
    wget \
    git \
    ca-certificates \
    gnupg \
    build-essential \
    cmake \
    ninja-build \
    pkg-config \
    xz-utils \
    python3 \
    python3-venv \
    python3-pip \
    lsb-release \
    dirmngr \
    apt-transport-https \
    gnupg2 \
    && rm -rf /var/lib/apt/lists/*

# Add LLVM apt repository for clang-19 and related tools
RUN curl -fsSL https://apt.llvm.org/llvm-snapshot.gpg.key | gpg --dearmor -o /usr/share/keyrings/llvm-snapshot.gpg \
    && echo "deb [signed-by=/usr/share/keyrings/llvm-snapshot.gpg] http://apt.llvm.org/jammy/ llvm-toolchain-jammy-19 main" > /etc/apt/sources.list.d/llvm-toolchain-jammy-19.list \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
        clang-19 \
        lld-19 \
        clang-tools-19 \
        clang-format-19 \
        clang-tidy-19 \
    && rm -rf /var/lib/apt/lists/*

# Install Node.js 18 from NodeSource
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - \
    && apt-get install -y nodejs \
    && rm -rf /var/lib/apt/lists/*

# Install rustup and Rust stable
RUN curl https://sh.rustup.rs -sSf | sh -s -- -y --no-modify-path \
    && /root/.cargo/bin/rustup default stable

# Install Deno v2.x (latest v2 release) - use direct binary install to avoid shell install issues
RUN DENO_VERSION="2.34.0" && \
    ARCH=$(dpkg --print-architecture) && \
    case "$ARCH" in \
      amd64) DENO_ARCH="x86_64-unknown-linux-gnu" ;; \
      arm64) DENO_ARCH="aarch64-unknown-linux-gnu" ;; \
      *) echo "Unsupported architecture: $ARCH" >&2; exit 1 ;; \
    esac && \
    curl -fsSL "https://github.com/denoland/deno/releases/download/v${DENO_VERSION}/deno-${DENO_ARCH}.zip" -o /tmp/deno.zip && \
    apt-get update && apt-get install -y unzip && \
    unzip /tmp/deno.zip -d /usr/local/bin && \
    rm /tmp/deno.zip && \
    chmod +x /usr/local/bin/deno && \
    apt-get remove -y unzip && apt-get autoremove -y && apt-get clean && rm -rf /var/lib/apt/lists/*

WORKDIR /workspace

# Copy source code
COPY . /workspace

# Copy run script
COPY run.sh /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh

ENTRYPOINT ["/usr/local/bin/run.sh"]