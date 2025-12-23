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

# Install Rust using rustup
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
ENV PATH="/root/.cargo/bin:${PATH}"

# Set the working directory
WORKDIR /app

# Create and activate virtual environment
RUN python3 -m venv /venv
ENV PATH="/venv/bin:$PATH"

# Install Python dependencies
# First check if requirements.txt exists before trying to install
COPY . .
RUN if [ -f "requirements.txt" ]; then \
    pip install --upgrade pip && \
    pip install -r requirements.txt; \
    fi

# Only add digest patch if not already present in Cargo.toml
RUN if ! grep -q 'digest = { version = "0.10", features = \["oid"\] }' Cargo.toml; then \
    echo '[patch.crates-io]' >> Cargo.toml && \
    echo 'digest = { version = "0.10", features = ["oid"] }' >> Cargo.toml; \
    fi

# Copy the run.sh script and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set the entrypoint to run.sh
ENTRYPOINT ["/app/run.sh"]