# Dockerfile
FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install necessary packages
RUN apt-get update && apt-get install -y \
    curl \
    unzip \
    software-properties-common \
    && rm -rf /var/lib/apt/lists/*

# Install dependencies for Zulu OpenJDK 17
RUN apt-get update && apt-get install -y \
    java-common \
    libasound2 \
    libx11-6 \
    libxau6 \
    libxcb1 \
    libxdmcp6 \
    libxext6 \
    libxi6 \
    libxrender1 \
    libxtst6 \
    libfontconfig1 \
    && rm -rf /var/lib/apt/lists/*

# Install Zulu OpenJDK 17
RUN curl -sSL https://cdn.azul.com/zulu/bin/zulu17.32.13-ca-jdk17.0.2-linux_amd64.deb -o zulu17.deb && \
    apt-get install -y ./zulu17.deb && \
    rm zulu17.deb

# Install Gradle
RUN curl -sSL https://services.gradle.org/distributions/gradle-7.4.2-bin.zip -o gradle.zip && \
    unzip gradle.zip -d /opt && \
    ln -s /opt/gradle-7.4.2/bin/gradle /usr/bin/gradle && \
    rm gradle.zip

# Create work directory
WORKDIR /app

# Copy repository contents
COPY . .

# Copy run.sh and make it executable
COPY run.sh /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh

# Set entrypoint
ENTRYPOINT ["/usr/local/bin/run.sh"]