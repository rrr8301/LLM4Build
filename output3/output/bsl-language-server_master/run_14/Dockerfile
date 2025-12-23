# Dockerfile
FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install necessary packages
RUN apt-get update && \
    apt-get install -y wget unzip curl && \
    apt-get clean

# Install OpenJDK 17
RUN apt-get update && \
    apt-get install -y openjdk-17-jdk && \
    apt-get clean

ENV JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64
ENV PATH="$JAVA_HOME/bin:$PATH"

# Install Gradle
RUN wget https://services.gradle.org/distributions/gradle-8.2-bin.zip && \
    unzip gradle-8.2-bin.zip -d /opt && \
    rm gradle-8.2-bin.zip

ENV GRADLE_HOME=/opt/gradle-8.2
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