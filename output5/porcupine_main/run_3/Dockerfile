# Dockerfile
FROM golang:1.20

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN apt-get update && apt-get install -y tzdata && \
    ln -fs /usr/share/zoneinfo/America/Los_Angeles /etc/localtime && \
    dpkg-reconfigure -f noninteractive tzdata

# Install git and dos2unix
RUN apt-get update && apt-get install -y git dos2unix

# Create work directory
WORKDIR /app

# Copy repository files
COPY . .

# Install Go dependencies
RUN go mod download || true

# Ensure run.sh has Unix line endings and is executable
RUN dos2unix /app/run.sh && chmod +x /app/run.sh

# Set entrypoint
ENTRYPOINT ["/app/run.sh"]