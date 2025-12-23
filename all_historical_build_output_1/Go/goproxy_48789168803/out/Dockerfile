FROM ubuntu:latest

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install dependencies including C compiler for cgo
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    git \
    wget \
    ca-certificates \
    gcc \
    libc6-dev \
    && rm -rf /var/lib/apt/lists/*

# Install Go using the official Go installer (more reliable)
RUN wget -O go.tar.gz https://go.dev/dl/go1.24.0.linux-amd64.tar.gz && \
    tar -C /usr/local -xzf go.tar.gz && \
    rm go.tar.gz

# Set Go environment variables including CGO_ENABLED
ENV PATH="/usr/local/go/bin:${PATH}"
ENV GOPATH=/go
ENV PATH=$GOPATH/bin:$PATH
ENV CGO_ENABLED=1

# Create work directory
WORKDIR /app

# Copy repository files
COPY . .

# Copy run.sh and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set entrypoint
ENTRYPOINT ["/app/run.sh"]