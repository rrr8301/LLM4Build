# Dockerfile
FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install necessary packages
RUN apt-get update && \
    apt-get install -y wget unzip curl && \
    rm -rf /var/lib/apt/lists/*

# Install OpenJDK 21
RUN mkdir -p /opt/jdk-21 && \
    curl -L -o openjdk-21_linux-x64_bin.tar.gz https://download.oracle.com/java/21/latest/jdk-21_linux-x64_bin.tar.gz && \
    tar -xvf openjdk-21_linux-x64_bin.tar.gz -C /opt/jdk-21 --strip-components=1 && \
    rm openjdk-21_linux-x64_bin.tar.gz && \
    update-alternatives --install /usr/bin/java java /opt/jdk-21/bin/java 1

# Install Gradle
RUN wget https://services.gradle.org/distributions/gradle-7.6-bin.zip && \
    unzip gradle-7.6-bin.zip -d /opt && \
    ln -s /opt/gradle-7.6/bin/gradle /usr/bin/gradle && \
    rm gradle-7.6-bin.zip

# Create work directory
WORKDIR /app

# Copy repository contents
COPY . .

# Ensure gradlew is executable
RUN chmod +x ./gradlew

# Copy run.sh and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set entrypoint
ENTRYPOINT ["/app/run.sh"]