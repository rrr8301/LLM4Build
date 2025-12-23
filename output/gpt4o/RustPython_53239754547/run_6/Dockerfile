# Dockerfile
FROM ubuntu:latest

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install dependencies including Python
RUN apt-get update && apt-get install -y \
    curl \
    build-essential \
    libssl-dev \
    pkg-config \
    git \
    python3 \
    python3-dev \
    python3-pip

# Install Rust
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
ENV PATH="/root/.cargo/bin:${PATH}"

# Install clippy and rustfmt
RUN rustup component add clippy rustfmt

# Create work directory
WORKDIR /app

# Copy repository
COPY . .

# Create necessary directories and fix Python standard library files
RUN mkdir -p Lib/python_builtins Lib/core_modules && \
    find Lib/ -type f -name "*.py" -exec sed -i 's/^[ \t]*//' {} \; && \
    echo -e "def hello():\n    print('Hello world!')" > Lib/python_builtins/__hello__.py && \
    echo -e "# encoding: utf-8\n\ndef get_codec():\n    import codecs\n    return codecs.lookup('utf-8')" > Lib/core_modules/encodings_utf_8.py

# Copy run.sh and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set entrypoint
ENTRYPOINT ["/app/run.sh"]