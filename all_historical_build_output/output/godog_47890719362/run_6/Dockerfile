# Dockerfile
FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install dependencies
RUN apt-get update && apt-get install -y \
    curl \
    git \
    dos2unix \
    && rm -rf /var/lib/apt/lists/*

# Install Go (updated to a newer version)
RUN curl -sSL https://golang.org/dl/go1.21.0.linux-amd64.tar.gz | tar -C /usr/local -xz
ENV PATH="/usr/local/go/bin:${PATH}"

# Create work directory
WORKDIR /app

# Copy repository files
COPY . .

# Install Go tools
RUN /usr/local/go/bin/go install honnef.co/go/tools/cmd/staticcheck@latest
RUN /usr/local/go/bin/go install github.com/cucumber/godog/cmd/godog@latest

# Ensure Go tools are in the PATH
ENV PATH="/root/go/bin:${PATH}"

# Copy run.sh and make it executable
COPY run.sh /app/run.sh
RUN dos2unix /app/run.sh && chmod +x /app/run.sh

# Set entrypoint
ENTRYPOINT ["/app/run.sh"]