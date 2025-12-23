# Dockerfile
FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install necessary packages and dependencies for Zulu JDK
RUN apt-get update && apt-get install -y \
    curl \
    wget \
    unzip \
    maven \
    libx11-6 \
    libxau6 \
    libxcb1 \
    libxdmcp6 \
    libxext6 \
    libxi6 \
    libxrender1 \
    libxtst6 \
    && rm -rf /var/lib/apt/lists/*

# Set up JDK 17 (Zulu distribution)
RUN wget -qO- https://cdn.azul.com/zulu/bin/zulu17.32.13-ca-jdk17.0.2-linux_amd64.deb -O zulu17.deb && \
    apt-get install -y ./zulu17.deb && \
    rm zulu17.deb

# Create work directory
WORKDIR /app

# Copy only necessary files to reduce context size
COPY pom.xml /app/
COPY src /app/src

# Copy run.sh and make it executable
COPY run.sh /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh

# Set entrypoint
ENTRYPOINT ["/usr/local/bin/run.sh"]