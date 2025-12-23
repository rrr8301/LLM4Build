# Dockerfile
FROM ubuntu:22.04

# Install necessary packages
RUN apt-get update && apt-get install -y \
    curl \
    unzip \
    && rm -rf /var/lib/apt/lists/*

# Set up JDK 21 (Temurin)
RUN curl -L -o /tmp/openjdk-21.tar.gz https://github.com/adoptium/temurin21-binaries/releases/download/jdk-21%2B35/OpenJDK21U-jdk_x64_linux_hotspot_21_35.tar.gz \
    && mkdir -p /opt/java/openjdk \
    && tar -xzf /tmp/openjdk-21.tar.gz -C /opt/java/openjdk --strip-components=1 \
    && rm /tmp/openjdk-21.tar.gz

ENV JAVA_HOME=/opt/java/openjdk
ENV PATH="$JAVA_HOME/bin:$PATH"

# Install Gradle
RUN curl -L -o /tmp/gradle.zip https://services.gradle.org/distributions/gradle-7.6-bin.zip \
    && unzip /tmp/gradle.zip -d /opt/gradle \
    && rm /tmp/gradle.zip

ENV GRADLE_HOME=/opt/gradle/gradle-7.6
ENV PATH="$GRADLE_HOME/bin:$PATH"

# Create work directory
WORKDIR /app

# Copy repository contents
COPY . .

# Copy run.sh and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set entrypoint
ENTRYPOINT ["/app/run.sh"]