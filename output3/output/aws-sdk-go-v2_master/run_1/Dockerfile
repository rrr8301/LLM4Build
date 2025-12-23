# Dockerfile
FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Set non-interactive mode for apt-get
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update && apt-get install -y \
    wget \
    make \
    && rm -rf /var/lib/apt/lists/*

# Install Go (use a valid version, e.g., 1.20.7)
RUN wget https://go.dev/dl/go1.20.7.linux-amd64.tar.gz && \
    tar -C /usr/local -xzf go1.20.7.linux-amd64.tar.gz && \
    rm go1.20.7.linux-amd64.tar.gz
ENV PATH="/usr/local/go/bin:${PATH}"

# Install golint
RUN go install golang.org/x/lint/golint@latest

# Create work directory
WORKDIR /app

# Copy repository
COPY . .

# Download and set up Coretto 17 JDK
RUN wget -O /tmp/java_package.tar.gz https://corretto.aws/downloads/latest/amazon-corretto-17-x64-linux-jdk.tar.gz && \
    tar -xzf /tmp/java_package.tar.gz -C /usr/local && \
    rm /tmp/java_package.tar.gz

# Copy run.sh and make it executable
COPY run.sh /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh

# Set entrypoint
ENTRYPOINT ["/usr/local/bin/run.sh"]