# Dockerfile
FROM ubuntu:22.04

# Install OS-level dependencies
RUN apt-get update && apt-get install -y \
    curl \
    build-essential \
    pkg-config \
    libssl-dev \
    libffi-dev \
    python3-dev \
    git

# Install Rust
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
ENV PATH="/root/.cargo/bin:${PATH}"

# Install pyenv dependencies
RUN apt-get install -y make libbz2-dev libreadline-dev libsqlite3-dev wget llvm libncurses5-dev libncursesw5-dev xz-utils tk-dev liblzma-dev

# Install pyenv
RUN git clone https://github.com/pyenv/pyenv.git /root/.pyenv
ENV PYENV_ROOT="/root/.pyenv"
ENV PATH="$PYENV_ROOT/bin:$PATH"
RUN echo 'eval "$(pyenv init --path)"' >> /root/.bashrc
RUN /bin/bash -c "source /root/.bashrc && pyenv install 3.12.0 && pyenv global 3.12.0"

# Install cargo-nextest
RUN cargo install cargo-nextest

# Create work directory
WORKDIR /app

# Copy repository contents
COPY . .

# Copy and set run.sh as entrypoint
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh
ENTRYPOINT ["/app/run.sh"]