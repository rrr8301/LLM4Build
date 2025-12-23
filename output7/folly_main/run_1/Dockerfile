# Use Ubuntu 22.04 as the base image
FROM ubuntu:22.04

# Set the timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install required packages
RUN apt-get update && apt-get install -y \
    git \
    python3 \
    python3-pip \
    cmake \
    g++ \
    make \
    sudo \
    libssl-dev  # Add OpenSSL development libraries

# Create a working directory
WORKDIR /app

# Copy the repository into the container
COPY . .

# Make run.sh executable
RUN chmod +x /app/run.sh

# Set the entrypoint to run.sh
ENTRYPOINT ["/app/run.sh"]