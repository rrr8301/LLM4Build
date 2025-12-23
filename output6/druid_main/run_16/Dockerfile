# Use the official Docker-in-Docker image
FROM docker:20.10.24-dind

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN apk add --no-cache tzdata && \
    cp /usr/share/zoneinfo/$TZ /etc/localtime && \
    echo $TZ > /etc/timezone

# Install dependencies
RUN apk add --no-cache \
    openjdk17 \
    git \
    wget \
    python3 \
    py3-pip \
    bind-tools \
    net-tools \
    ca-certificates \
    curl \
    gnupg \
    lsb-release \
    dos2unix

# Install Python packages
RUN pip3 install pyyaml

# Install Maven 3.8.8 or higher
RUN wget https://archive.apache.org/dist/maven/maven-3/3.8.8/binaries/apache-maven-3.8.8-bin.tar.gz && \
    tar xzvf apache-maven-3.8.8-bin.tar.gz -C /opt && \
    ln -s /opt/apache-maven-3.8.8/bin/mvn /usr/bin/mvn && \
    rm apache-maven-3.8.8-bin.tar.gz

# Create work directory
WORKDIR /app

# Copy repository contents
COPY . .

# Ensure run.sh has Unix line endings and is executable
RUN dos2unix /app/run.sh && chmod +x /app/run.sh

# Set entrypoint
ENTRYPOINT ["/bin/sh", "-c", "/app/run.sh"]