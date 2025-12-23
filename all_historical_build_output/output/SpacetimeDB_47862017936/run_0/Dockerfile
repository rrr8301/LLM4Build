FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install dependencies
RUN apt-get update && apt-get install -y \
    curl \
    git \
    sudo \
    build-essential \
    libssl-dev \
    pkg-config \
    && rm -rf /var/lib/apt/lists/*

# Install Rust
RUN curl https://sh.rustup.rs -sSf | sh -s -- -y
ENV PATH="/root/.cargo/bin:${PATH}"

# Install .NET SDK
COPY modules/global.json /tmp/global.json
RUN curl -sSL https://dot.net/v1/dotnet-install.sh | bash /dev/stdin --jsonfile /tmp/global.json

# Create work directory
RUN mkdir /app
WORKDIR /app

# Copy repository
COPY . .

# Create /stdb directory
RUN mkdir /stdb && chmod 777 /stdb

# Copy run.sh and make it executable
COPY run.sh /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh

# Set entrypoint
ENTRYPOINT ["/usr/local/bin/run.sh"]