# Use the OpenJDK base image
FROM openjdk:8-jdk-slim

# Set the timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN apt-get update && \
    apt-get install -y --no-install-recommends tzdata git wget unzip && \
    ln -fs /usr/share/zoneinfo/$TZ /etc/localtime && \
    dpkg-reconfigure -f noninteractive tzdata && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Create a working directory
WORKDIR /app

# Copy the repository into the container
COPY . .

# Ensure the Gradle wrapper is executable
RUN chmod +x ./gradlew

# Set the entrypoint
ENTRYPOINT ["/app/run.sh"]