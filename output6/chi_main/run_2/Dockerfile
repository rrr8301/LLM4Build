# Use the official Ubuntu 22.04 as a parent image
FROM ubuntu:22.04

# Set the timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install necessary packages
RUN apt-get update && apt-get install -y \
    git \
    make \
    wget \
    gcc \
    libc6-dev \
    && rm -rf /var/lib/apt/lists/*

# Install Go
RUN wget https://go.dev/dl/go1.20.7.linux-amd64.tar.gz && \
    tar -C /usr/local -xzf go1.20.7.linux-amd64.tar.gz && \
    rm go1.20.7.linux-amd64.tar.gz

# Set Go environment variables
ENV PATH="/usr/local/go/bin:${PATH}"

# Enable CGO
ENV CGO_ENABLED=1

# Create and set the working directory
WORKDIR /app

# Copy the repository contents into the container
COPY . .

# Copy the run.sh script into the container and make it executable
COPY run.sh /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh

# Set the entrypoint to run.sh
ENTRYPOINT ["/usr/local/bin/run.sh"]