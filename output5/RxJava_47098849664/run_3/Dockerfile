FROM ubuntu:22.04

# Install necessary packages
RUN apt-get update && \
    apt-get install -y wget unzip openjdk-11-jdk && \
    rm -rf /var/lib/apt/lists/*

# Set environment variables for Java
ENV JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
ENV PATH="$JAVA_HOME/bin:$PATH"

# Install Gradle
RUN wget https://services.gradle.org/distributions/gradle-7.5-bin.zip -P /tmp && \
    unzip -d /opt/gradle /tmp/gradle-7.5-bin.zip && \
    ln -s /opt/gradle/gradle-7.5/bin/gradle /usr/bin/gradle

# Copy the repository
COPY . /app
WORKDIR /app

# Copy run.sh and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set the entrypoint
ENTRYPOINT ["/app/run.sh"]