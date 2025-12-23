# Dockerfile
FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install necessary packages
RUN apt-get update && \
    apt-get install -y wget unzip && \
    apt-get clean

# Install Temurin JDK 17
RUN wget https://github.com/adoptium/temurin17-binaries/releases/download/jdk-17.0.8+7/OpenJDK17U-jdk_x64_linux_hotspot_17.0.8_7.tar.gz && \
    tar -xzf OpenJDK17U-jdk_x64_linux_hotspot_17.0.8_7.tar.gz -C /opt && \
    rm OpenJDK17U-jdk_x64_linux_hotspot_17.0.8_7.tar.gz && \
    ln -s /opt/jdk-17.0.8+7 /opt/jdk

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

# Copy run.sh and make it executable
COPY run.sh /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh

# Set entrypoint
ENTRYPOINT ["/usr/local/bin/run.sh"]