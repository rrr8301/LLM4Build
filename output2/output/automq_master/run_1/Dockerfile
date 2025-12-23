# Dockerfile
FROM openjdk:17-jdk-alpine

# Set the timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN apk add --no-cache tzdata && \
    cp /usr/share/zoneinfo/$TZ /etc/localtime && \
    echo $TZ > /etc/timezone && \
    apk del tzdata

# Install necessary packages
RUN apk update && apk add --no-cache wget unzip bash

# Install Gradle
RUN wget https://services.gradle.org/distributions/gradle-7.5-bin.zip -P /tmp && \
    unzip -d /opt/gradle /tmp/gradle-7.5-bin.zip && \
    ln -s /opt/gradle/gradle-7.5/bin/gradle /usr/bin/gradle && \
    rm /tmp/gradle-7.5-bin.zip

# Create work directory
WORKDIR /app

# Copy the repository
COPY . .

# Copy run.sh and make it executable
COPY run.sh /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh

# Set the entrypoint
ENTRYPOINT ["/usr/local/bin/run.sh"]