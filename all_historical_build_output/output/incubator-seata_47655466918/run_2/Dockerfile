# Use Ubuntu 22.04 as the base image
FROM ubuntu:22.04

# Install required packages
RUN apt-get update && apt-get install -y \
    software-properties-common \
    curl \
    git \
    openjdk-17-jdk \
    maven \
    python3.12 \
    python3.12-venv \
    && rm -rf /var/lib/apt/lists/*

# Set up environment variables
ENV JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64
ENV PATH="$JAVA_HOME/bin:$PATH"

# Create a working directory
WORKDIR /app

# Copy the repository into the container
COPY . .

# Copy the run.sh script and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set the entrypoint to run.sh
ENTRYPOINT ["/app/run.sh"]