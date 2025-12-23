FROM openjdk:17-slim

# Install required packages
RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    bash \
    curl \
    unzip \
    tar \
    gcc \
    g++ \
    make \
    ca-certificates \
 && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy the entire repository
COPY . /app

# Copy run.sh and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set entrypoint
ENTRYPOINT ["/app/run.sh"]