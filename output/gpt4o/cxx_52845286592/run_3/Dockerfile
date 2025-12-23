# Dockerfile
FROM ubuntu:latest

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install dependencies including CA certificates and git
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    ca-certificates \
    g++ \
    curl \
    git \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Configure git symlinks (needed for cxx build)
RUN git config --global core.symlinks true

# Install Rust
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
ENV PATH="/root/.cargo/bin:${PATH}"

# Set up Rust toolchain
RUN rustup component add rust-src

# Create work directory
WORKDIR /app

# Copy repository with proper symlink handling
COPY --chmod=644 . .

# Reinitialize git repository with symlinks enabled
RUN if [ -d .git ]; then \
      rm -rf .git && \
      git init && \
      git config core.symlinks true && \
      git add . && \
      git commit -m "Initial commit"; \
    fi

# Copy run.sh and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set entrypoint
ENTRYPOINT ["/app/run.sh"]