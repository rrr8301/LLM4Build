# Dockerfile
FROM ubuntu:22.04

# Install required packages
RUN apt-get update && apt-get install -y \
    git \
    maven \
    openjdk-21-jdk \
    dos2unix \
    && rm -rf /var/lib/apt/lists/*

# Set environment variables
ENV JAVA_HOME=/usr/lib/jvm/java-21-openjdk-amd64
ENV PATH="$JAVA_HOME/bin:$PATH"

# Copy the repository into the Docker image
COPY . /app
WORKDIR /app

# Ensure the VERSION file exists or create a default one
RUN if [ ! -f VERSION ]; then echo "0.0.1" > VERSION; fi

# Copy the run.sh script and make it executable
COPY run.sh /app/run.sh
RUN dos2unix /app/run.sh && chmod +x /app/run.sh

# Set the entrypoint
ENTRYPOINT ["/app/run.sh"]