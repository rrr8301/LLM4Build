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

# Set up Gradle
RUN curl -s "https://services.gradle.org/distributions/gradle-7.5-bin.zip" -o gradle.zip \
    && unzip gradle.zip -d /opt/gradle \
    && rm gradle.zip
ENV PATH="/opt/gradle/gradle-7.5/bin:${PATH}"

# Create work directory
WORKDIR /app

# Copy repository contents
COPY . .

# Copy run.sh and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set entrypoint
ENTRYPOINT ["/app/run.sh"]