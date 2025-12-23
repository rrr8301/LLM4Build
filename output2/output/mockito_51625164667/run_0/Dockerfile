# Dockerfile
FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install Java and Gradle
RUN apt-get update && \
    apt-get install -y wget unzip && \
    wget https://download.java.net/java/GA/jdk21/latest/binaries/openjdk-21_linux-x64_bin.tar.gz && \
    tar -xvf openjdk-21_linux-x64_bin.tar.gz && \
    mv jdk-21 /opt/ && \
    update-alternatives --install /usr/bin/java java /opt/jdk-21/bin/java 1 && \
    wget https://services.gradle.org/distributions/gradle-7.6-bin.zip && \
    unzip gradle-7.6-bin.zip -d /opt && \
    ln -s /opt/gradle-7.6/bin/gradle /usr/bin/gradle

# Create work directory
WORKDIR /app

# Copy repository contents
COPY . .

# Copy run.sh and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set entrypoint
ENTRYPOINT ["/app/run.sh"]