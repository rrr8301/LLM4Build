FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install dependencies
RUN apt-get update && apt-get install -y \
    curl \
    make \
    sudo \
    tcpdump \
    gcc \
    && rm -rf /var/lib/apt/lists/*

# Install Go (updating to a version that supports the required packages)
RUN curl -sSL https://golang.org/dl/go1.24.10.linux-amd64.tar.gz | tar -C /usr/local -xz
ENV PATH="/usr/local/go/bin:${PATH}"

# Install Docker Compose
RUN curl --fail -sSL "https://github.com/docker/compose/releases/download/v2.32.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose \
    && chmod +x /usr/local/bin/docker-compose

# Create work directory
WORKDIR /app

# Copy repository
COPY . .

# Install Go packages (using a different version of tparse)
RUN go install github.com/mfridman/tparse@v0.17.0

# Copy run.sh and make it executable
COPY run.sh /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh

# Set entrypoint
ENTRYPOINT ["/usr/local/bin/run.sh"]