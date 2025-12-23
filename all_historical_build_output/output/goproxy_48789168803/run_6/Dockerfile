# Dockerfile
FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -fs /usr/share/zoneinfo/$TZ /etc/localtime && \
    apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y tzdata

# Install dependencies
RUN apt-get update && \
    apt-get install -y curl git dos2unix

# Install Go
RUN curl -sSL https://golang.org/dl/go1.20.5.linux-amd64.tar.gz | tar -C /usr/local -xz

# Set Go environment variables
ENV PATH="/usr/local/go/bin:${PATH}"

# Create work directory
WORKDIR /app

# Copy repository contents
COPY . .

# Ensure run.sh has Unix-style line endings
RUN dos2unix /app/run.sh

# Make run.sh executable
RUN chmod +x /app/run.sh

# Set entrypoint
ENTRYPOINT ["/app/run.sh"]