FROM ubuntu:24.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    wget \
    python3 \
    python3-pip \
    clang \
    cmake \
    ninja-build \
    && rm -rf /var/lib/apt/lists/*

# Install Clang and BOLT if needed
RUN wget -O - https://apt.llvm.org/llvm.sh | bash -s 19 && \
    apt-get install -y bolt-19

# Create work directory
WORKDIR /app

# Copy repository
COPY . .

# Install OpenSSL
RUN python3 Tools/ssl/multissltests.py --steps=library --base-directory /app/multissl --openssl 3.0.18 --system Linux

# Copy run.sh and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set entrypoint
ENTRYPOINT ["/app/run.sh"]