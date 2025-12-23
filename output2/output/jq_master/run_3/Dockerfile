# Use the base image
FROM ubuntu:22.04

# Set the timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    automake autoconf libtool make git build-essential ca-certificates && \
    rm -rf /var/lib/apt/lists/*

# Create work directory
WORKDIR /app

# Copy the repository into the container
COPY . .

# Initialize and update submodules
RUN git submodule update --init --recursive

# Copy the run.sh script and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set the entrypoint to run.sh
ENTRYPOINT ["/app/run.sh"]