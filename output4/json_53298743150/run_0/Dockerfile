# Dockerfile
FROM gcc:latest

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    cmake \
    ninja-build \
    git && \
    rm -rf /var/lib/apt/lists/*

# Create work directory
WORKDIR /usr/src/app

# Copy the repository into the container
COPY . .

# Copy run.sh and make it executable
COPY run.sh /usr/src/app/run.sh
RUN chmod +x /usr/src/app/run.sh

# Set the entrypoint
ENTRYPOINT ["/usr/src/app/run.sh"]