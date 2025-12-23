# Dockerfile
FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install necessary packages
RUN apt-get update && apt-get install -y \
    curl \
    unzip \
    openjdk-17-jdk \
    && rm -rf /var/lib/apt/lists/*

# Install Gradle
RUN curl -L -o gradle.zip https://services.gradle.org/distributions/gradle-7.6-bin.zip && \
    unzip gradle.zip -d /opt && \
    rm gradle.zip
ENV GRADLE_HOME=/opt/gradle-7.6
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