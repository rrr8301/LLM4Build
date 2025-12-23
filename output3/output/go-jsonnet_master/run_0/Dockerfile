# Dockerfile
FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -fs /usr/share/zoneinfo/$TZ /etc/localtime && \
    apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y tzdata

# Install OS-level dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    make \
    git \
    wget \
    curl \
    build-essential \
    python3.12 \
    python3-pip \
    golang-go

# Set up Python environment
RUN python3.12 -m pip install --upgrade pip

# Create work directory
WORKDIR /app

# Copy repository
COPY . .

# Install Python packages
RUN pip install -U wheel pytest setuptools

# Install Go package
RUN go install github.com/mattn/goveralls@v0.0.12

# Copy run.sh and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set entrypoint
ENTRYPOINT ["/app/run.sh"]