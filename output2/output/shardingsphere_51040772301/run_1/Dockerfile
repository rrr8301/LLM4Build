# Dockerfile
FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Ensure non-interactive installation
ENV DEBIAN_FRONTEND=noninteractive

# Create necessary directories
RUN mkdir -p /usr/share/binfmts

# Install dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    openjdk-11-jdk \
    openjdk-8-jdk \
    maven \
    git \
    && rm -rf /var/lib/apt/lists/*

# Set environment variables for Maven
ENV MAVEN_OPTS="-Dhttp.keepAlive=false -Dmaven.wagon.http.pool=false -Dmaven.wagon.http.retryHandler.class=standard -Dmaven.wagon.http.retryHandler.count=3 -Dspotless.apply.skip=true"

# Create work directory
WORKDIR /app

# Copy repository files
COPY . .

# Copy run.sh and make it executable
COPY run.sh /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh

# Set entrypoint
ENTRYPOINT ["/usr/local/bin/run.sh"]