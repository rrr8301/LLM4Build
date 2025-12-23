# Dockerfile
FROM gcc:latest

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install CMake and Ninja
RUN apt-get update && \
    apt-get install -y cmake ninja-build && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Create work directory
WORKDIR /usr/src/app

# Copy the repository into the container
COPY . .

# Copy run.sh and make it executable
COPY run.sh /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh

# Set the entrypoint
ENTRYPOINT ["/usr/local/bin/run.sh"]