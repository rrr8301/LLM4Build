# Use OpenJDK 17 with a non-Alpine base image
FROM openjdk:17-jdk-slim

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN apt-get update && apt-get install -y tzdata && \
    ln -sf /usr/share/zoneinfo/$TZ /etc/localtime && \
    echo $TZ > /etc/timezone && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Install Maven and dos2unix
RUN apt-get update && apt-get install -y maven dos2unix && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Set environment variable for Maven to increase heap size
ENV MAVEN_OPTS="-Xmx4096m"

# Create work directory
WORKDIR /app

# Copy repository contents
COPY . .

# Ensure run.sh has Unix-style line endings and make it executable
RUN dos2unix /app/run.sh && chmod +x /app/run.sh

# Set entrypoint
ENTRYPOINT ["/bin/sh", "/app/run.sh"]