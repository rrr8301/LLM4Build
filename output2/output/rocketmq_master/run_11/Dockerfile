# Use OpenJDK 17 with Alpine Linux
FROM openjdk:17-jdk-alpine

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN apk add --no-cache tzdata && \
    cp /usr/share/zoneinfo/$TZ /etc/localtime && \
    echo $TZ > /etc/timezone && \
    apk del tzdata

# Install Maven and dos2unix
RUN apk add --no-cache maven dos2unix

# Set environment variable for Maven to increase heap size
ENV MAVEN_OPTS="-Xmx20480m"

# Create work directory
WORKDIR /app

# Copy repository contents
COPY . .

# Ensure run.sh has Unix-style line endings and make it executable
RUN dos2unix /app/run.sh && chmod +x /app/run.sh

# Set entrypoint
ENTRYPOINT ["/bin/sh", "/app/run.sh"]