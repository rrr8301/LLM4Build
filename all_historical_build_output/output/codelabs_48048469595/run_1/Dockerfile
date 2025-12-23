# Dockerfile
FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install dependencies
RUN apt-get update && apt-get install -y \
    curl \
    unzip \
    git \
    openjdk-17-jdk \
    && rm -rf /var/lib/apt/lists/*

# Set up Flutter
RUN git clone https://github.com/flutter/flutter.git /usr/local/flutter \
    && /usr/local/flutter/bin/flutter channel stable \
    && /usr/local/flutter/bin/flutter upgrade \
    && /usr/local/flutter/bin/flutter doctor -v

# Set environment variables
ENV PATH="/usr/local/flutter/bin:/usr/local/flutter/bin/cache/dart-sdk/bin:${PATH}"

# Create work directory
WORKDIR /app

# Copy repository contents
COPY . .

# Copy run.sh and make it executable
COPY run.sh /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh

# Set entrypoint
ENTRYPOINT ["/usr/local/bin/run.sh"]