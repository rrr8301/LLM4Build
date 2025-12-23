FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install necessary packages
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    python3 \
    python3-pip \
    git \
    build-essential \
    cmake \
    ninja-build \
    patchelf \
    && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Create work directory
WORKDIR /app

# Copy the repository into the container
COPY . .

# Make run.sh executable and set as entrypoint
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh
ENTRYPOINT ["/app/run.sh"]