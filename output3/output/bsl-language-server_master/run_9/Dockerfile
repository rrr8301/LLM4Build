# Dockerfile
FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install necessary packages
RUN apt-get update && \
    apt-get install -y wget unzip curl && \
    apt-get clean

# Install Temurin JDK 21 using a package manager
RUN mkdir -p /opt/jdk && \
    curl -L -o /opt/jdk/OpenJDK21U-jdk_x64_linux_hotspot.tar.gz https://github.com/adoptium/temurin21-binaries/releases/download/jdk-21.0.0+35/OpenJDK21U-jdk_x64_linux_hotspot_21.0.0_35.tar.gz && \
    tar -xzf /opt/jdk/OpenJDK21U-jdk_x64_linux_hotspot.tar.gz -C /opt/jdk --strip-components=1 && \
    rm /opt/jdk/OpenJDK21U-jdk_x64_linux_hotspot.tar.gz

ENV JAVA_HOME=/opt/jdk
ENV PATH="$JAVA_HOME/bin:$PATH"

# Install Gradle
RUN wget https://services.gradle.org/distributions/gradle-7.6-bin.zip && \
    unzip gradle-7.6-bin.zip -d /opt && \
    rm gradle-7.6-bin.zip

ENV GRADLE_HOME=/opt/gradle-7.6
ENV PATH="$GRADLE_HOME/bin:$PATH"

# Create work directory
WORKDIR /app

# Copy repository
COPY . .

# Ensure Gradle wrapper is executable
RUN chmod +x ./gradlew

# Copy run.sh and make it executable
COPY run.sh /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh

# Set entrypoint
ENTRYPOINT ["/usr/local/bin/run.sh"]