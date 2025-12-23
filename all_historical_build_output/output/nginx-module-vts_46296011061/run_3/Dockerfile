# Dockerfile
FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install dependencies with retry logic
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    apt-transport-https \
    ca-certificates \
    wget \
    build-essential \
    libpcre3-dev \
    zlib1g-dev \
    libssl-dev \
    perl \
    cpanminus && \
    cpanm Test::More && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Download and extract Nginx source code
WORKDIR /tmp
RUN wget http://nginx.org/download/nginx-1.18.0.tar.gz && \
    tar -xzvf nginx-1.18.0.tar.gz && \
    rm nginx-1.18.0.tar.gz

# Create work directory
WORKDIR /app

# Copy the repository
COPY . .

# Build Nginx with the module
WORKDIR /tmp/nginx-1.18.0
RUN ./configure --add-module=/app && make && make install

# Copy run.sh, make it executable and set as entrypoint
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh
ENTRYPOINT ["/app/run.sh"]