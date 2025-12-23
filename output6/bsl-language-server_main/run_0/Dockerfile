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

# Install JDK 17
RUN curl -sL https://download.java.net/java/GA/jdk17/latest/binaries/openjdk-17_linux-x64_bin.tar.gz | tar -xz -C /usr/local
ENV JAVA_HOME=/usr/local/jdk-17
ENV PATH="$JAVA_HOME/bin:$PATH"

# Install Gradle
RUN curl -sL https://services.gradle.org/distributions/gradle-7.5-bin.zip -o gradle.zip \
    && unzip gradle.zip -d /opt/gradle \
    && rm gradle.zip
ENV GRADLE_HOME=/opt/gradle/gradle-7.5
ENV PATH="$GRADLE_HOME/bin:$PATH"

# Create work directory
WORKDIR /app

# Copy repository contents
COPY . .

# Copy run.sh and make it executable
COPY run.sh /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh

# Set entrypoint
ENTRYPOINT ["/usr/local/bin/run.sh"]