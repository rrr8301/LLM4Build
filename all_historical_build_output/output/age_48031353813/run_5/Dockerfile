# Dockerfile
FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    libreadline-dev \
    zlib1g-dev \
    flex \
    bison \
    git \
    dos2unix \
    libicu-dev \
    pkg-config \
    && rm -rf /var/lib/apt/lists/*

# Create a non-root user
RUN useradd -ms /bin/bash pguser

# Create work directory
WORKDIR /app

# Copy repository contents
COPY . .

# Copy run.sh and make it executable
COPY run.sh /app/run.sh
RUN dos2unix /app/run.sh && chmod +x /app/run.sh

# Change ownership of the /app directory to the non-root user
RUN chown -R pguser:pguser /app

# Switch to the non-root user
USER pguser

# Set entrypoint
ENTRYPOINT ["/app/run.sh"]