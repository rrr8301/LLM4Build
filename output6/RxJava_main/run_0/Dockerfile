# Use the OpenJDK base image
FROM openjdk:11-jdk-slim

# Set the timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN apt-get update && \
    apt-get install -y --no-install-recommends tzdata git && \
    ln -fs /usr/share/zoneinfo/$TZ /etc/localtime && \
    dpkg-reconfigure -f noninteractive tzdata && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install Gradle
RUN apt-get update && \
    apt-get install -y --no-install-recommends wget unzip && \
    wget https://services.gradle.org/distributions/gradle-7.5-bin.zip -P /tmp && \
    unzip -d /opt/gradle /tmp/gradle-7.5-bin.zip && \
    ln -s /opt/gradle/gradle-7.5/bin/gradle /usr/bin/gradle && \
    rm /tmp/gradle-7.5-bin.zip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Create a working directory
WORKDIR /app

# Copy the repository into the container
COPY . .

# Copy the run.sh script and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set the entrypoint
ENTRYPOINT ["/app/run.sh"]