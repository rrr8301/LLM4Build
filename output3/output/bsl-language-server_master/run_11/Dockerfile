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
RUN apt-get update && \
    apt-get install -y software-properties-common && \
    add-apt-repository ppa:openjdk-r/ppa && \
    apt-get update && \
    apt-get install -y openjdk-21-jdk && \
    apt-get clean

ENV JAVA_HOME=/usr/lib/jvm/java-21-openjdk-amd64
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