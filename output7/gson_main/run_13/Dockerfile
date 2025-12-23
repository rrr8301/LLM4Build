# Use a specific version of the Debian-based OpenJDK image
FROM openjdk:17-jdk-slim

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN apt-get update && \
    apt-get install -y --no-install-recommends tzdata curl maven && \
    ln -fs /usr/share/zoneinfo/$TZ /etc/localtime && \
    echo $TZ > /etc/timezone && \
    dpkg-reconfigure -f noninteractive tzdata && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Create work directory
WORKDIR /app

# Copy repository contents
COPY . .

# Make run.sh executable
RUN chmod +x /app/run.sh

# Set entrypoint
ENTRYPOINT ["/app/run.sh"]