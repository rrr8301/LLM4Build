# Use Ubuntu 22.04 as the base image
FROM ubuntu:22.04

# Set the timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Ensure necessary directories exist and install required packages
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    apt-utils \
    && apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Create the directory for binfmt
RUN mkdir -p /usr/share/binfmts

# Install Java and other dependencies
RUN apt-get update && \
    mkdir -p /usr/share/binfmts && \
    apt-get install -y --no-install-recommends \
    openjdk-11-jdk \
    openjdk-8-jdk \
    maven \
    git \
    && apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Set environment variables for Maven
ENV MAVEN_OPTS="-Dhttp.keepAlive=false -Dmaven.wagon.http.pool=false -Dmaven.wagon.http.retryHandler.class=standard -Dmaven.wagon.http.retryHandler.count=3 -Dspotless.apply.skip=true"

# Create a work directory
WORKDIR /app

# Copy the repository into the container
COPY . .

# Copy the run.sh script and make it executable
COPY run.sh /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh

# Set the entrypoint to run.sh
ENTRYPOINT ["/usr/local/bin/run.sh"]