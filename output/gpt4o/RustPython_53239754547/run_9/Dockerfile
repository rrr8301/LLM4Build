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

# Fix Python standard library files formatting and ensure proper encoding
RUN find Lib/ -type f -name "*.py" -exec sed -i 's/^[ \t]*//' {} \; && \
    find Lib/ -type f -name "*.py" -exec sed -i '1s/^/# encoding: utf-8\n/' {} \; && \
    echo -e "# encoding: utf-8\n\ndef hello():\n    print('Hello world!')\n" > Lib/python_builtins/__hello__.py && \
    echo -e "# encoding: utf-8\n\ndef get_codec():\n    import codecs\n    return codecs.lookup('utf-8')\n" > Lib/core_modules/encodings_utf_8.py

# Install Python formatter and format files
RUN pip3 install black && \
    find Lib/ -type f -name "*.py" -exec black --quiet {} \;