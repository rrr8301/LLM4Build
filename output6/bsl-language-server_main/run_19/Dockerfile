# Dockerfile
FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install necessary packages
RUN apt-get update && apt-get install -y \
    curl \
    unzip \
    dos2unix \
    && rm -rf /var/lib/apt/lists/*

# Install OpenJDK 17
RUN apt-get update && apt-get install -y openjdk-17-jdk

# Set JAVA_HOME environment variable
ENV JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64
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

# Ensure all text files have the correct line endings
RUN find /app -type f -exec dos2unix {} +

# Ensure Gradle wrapper is executable
RUN chmod +x ./gradlew

# Copy run.sh and make it executable
COPY run.sh /usr/local/bin/run.sh
RUN dos2unix /usr/local/bin/run.sh && chmod +x /usr/local/bin/run.sh

# Set entrypoint
ENTRYPOINT ["/usr/local/bin/run.sh"]