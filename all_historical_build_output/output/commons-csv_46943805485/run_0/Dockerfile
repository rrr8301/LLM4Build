# Use Eclipse Temurin JDK 21 base image
FROM eclipse-temurin:21-jdk

# Install Maven and other required packages
RUN apt-get update && \
    apt-get install -y maven && \
    rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy the entire repository into the container
COPY . /app

# Copy the run script and make it executable
COPY run.sh /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh

# Set entrypoint to run.sh
ENTRYPOINT ["/usr/local/bin/run.sh"]