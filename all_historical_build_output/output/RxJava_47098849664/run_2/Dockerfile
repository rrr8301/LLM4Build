# Use Ubuntu 22.04 as the base image
FROM ubuntu:22.04

# Install necessary packages
RUN apt-get update && \
    apt-get install -y wget unzip openjdk-11-jdk && \
    apt-get clean

# Set the working directory
WORKDIR /app

# Copy the repository contents into the container
COPY . .

# Install Gradle manually
RUN wget https://services.gradle.org/distributions/gradle-8.14-bin.zip && \
    unzip gradle-8.14-bin.zip -d /opt && \
    rm gradle-8.14-bin.zip && \
    ln -s /opt/gradle-8.14/bin/gradle /usr/bin/gradle

# Copy the run.sh script and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set the entrypoint to run.sh
ENTRYPOINT ["/app/run.sh"]