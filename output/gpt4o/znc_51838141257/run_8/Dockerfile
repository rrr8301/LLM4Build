FROM ubuntu:24.04

# Set timezone to Pacific Time non-interactively
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install dependencies with DEBIAN_FRONTEND=noninteractive to avoid systemd issues
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    make \
    pkg-config \
    gcc \
    clang \
    cmake \
    openssl \
    libssl-dev \
    perl \
    swig \
    python3 \
    python3-pip \
    libpython3-dev \
    libicu-dev \
    gettext \
    libargon2-dev \
    git \
    curl \
    sudo \
    lcov \
    cpanminus \
    libmodule-install-perl \
    && rm -rf /var/lib/apt/lists/*

# Install Perl modules for coverage
RUN cpanm Devel::Cover Devel::Cover::Report::Clover

# Add pip user binaries to PATH
ENV PATH="/root/.local/bin:${PATH}"

# Create work directory
WORKDIR /app

# Copy repository contents (including .git if needed)
COPY . .

# Initialize git submodules recursively
RUN git submodule update --init --recursive || echo "Warning: Submodule initialization failed"

# Set execute permissions for scripts
RUN find . -type f -name "*.sh" -exec chmod +x {} \; && \
    chmod +x configure

# Copy run.sh and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set entrypoint
ENTRYPOINT ["/app/run.sh"]