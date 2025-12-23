FROM docker:20.10.7-dind

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN apk add --no-cache tzdata && \
    cp /usr/share/zoneinfo/$TZ /etc/localtime && \
    echo $TZ > /etc/timezone

# Install dependencies
RUN apk add --no-cache \
    openjdk11 \
    maven \
    curl \
    sudo

# Create work directory
WORKDIR /app

# Copy repository files
COPY . .

# Ensure run.sh is in the correct location and has the correct permissions
COPY run.sh /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh

# Set entrypoint
ENTRYPOINT ["/bin/sh", "-c", "/usr/local/bin/run.sh"]