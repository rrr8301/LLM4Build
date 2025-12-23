# Dockerfile
FROM openjdk:17-jdk-alpine

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN apk add --no-cache tzdata && \
    cp /usr/share/zoneinfo/$TZ /etc/localtime && \
    echo $TZ > /etc/timezone && \
    apk del tzdata

# Install Maven
RUN apk add --no-cache maven

# Create work directory
WORKDIR /app

# Copy repository contents
COPY . .

# Ensure run.sh has Unix-style line endings
RUN dos2unix run.sh

# Copy run.sh and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set entrypoint
ENTRYPOINT ["/app/run.sh"]