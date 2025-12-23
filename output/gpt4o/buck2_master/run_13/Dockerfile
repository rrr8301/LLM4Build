# Use a more recent base image that has Python 3.12
FROM ubuntu:24.04

# Set the timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install system dependencies including Rust
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    python3-venv \
    git \
    curl \
    build-essential \
    && apt-get clean

# Install Rust using rustup with specific nightly version
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --default-toolchain nightly-2025-09-14
ENV PATH="/root/.cargo/bin:${PATH}"

# Set the working directory
WORKDIR /app

# Create and activate virtual environment
RUN python3 -m venv /venv
ENV PATH="/venv/bin:$PATH"

# Copy the entire project first
COPY . .

# Update digest dependency to use a known working version from crates.io
RUN sed -i '/^\[patch\.crates-io\]/,/^\[/ {/digest/d}' Cargo.toml && \
    if ! grep -q '^\[patch\.crates-io\]' Cargo.toml; then \
        echo -e '\n[patch.crates-io]\ndigest = "0.10.7"' >> Cargo.toml; \
    else \
        sed -i '/^\[patch\.crates-io\]/a digest = "0.10.7"' Cargo.toml; \
    fi

# Install Python dependencies if requirements.txt exists
RUN if [ -f "requirements.txt" ]; then \
    pip install --upgrade pip && \
    pip install -r requirements.txt; \
    fi

# Copy the run.sh script and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set the entrypoint to run.sh
ENTRYPOINT ["/app/run.sh"]