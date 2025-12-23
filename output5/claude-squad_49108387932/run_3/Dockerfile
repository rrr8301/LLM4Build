# Dockerfile
FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install dependencies
RUN apt-get update && apt-get install -y \
    curl \
    git \
    tmux \
    gh \
    dos2unix \  # Add dos2unix to the list of installed packages
    && rm -rf /var/lib/apt/lists/*

# Install Go
RUN curl -fsSL https://golang.org/dl/go1.21.1.linux-amd64.tar.gz | tar -C /usr/local -xz
ENV PATH="/usr/local/go/bin:${PATH}"

# Create work directory
WORKDIR /app

# Copy repository
COPY . .

# Ensure run.sh has Unix line endings
RUN dos2unix run.sh

# Copy run.sh and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set entrypoint
ENTRYPOINT ["/bin/bash", "/app/run.sh"]