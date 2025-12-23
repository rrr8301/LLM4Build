# Dockerfile
FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install necessary packages
RUN apt-get update && apt-get install -y \
    curl \
    unzip \
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