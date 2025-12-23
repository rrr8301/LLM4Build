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

# Install Liberica JDK 17
RUN curl -L -o liberica-jdk.tar.gz https://download.bell-sw.com/java/17+35/bellsoft-jdk17+35-linux-amd64.tar.gz && \
    mkdir -p /opt/liberica && \
    tar -xzf liberica-jdk.tar.gz -C /opt/liberica --strip-components=1 && \
    rm liberica-jdk.tar.gz
ENV JAVA_HOME=/opt/liberica
ENV PATH="$JAVA_HOME/bin:$PATH"

# Install Gradle
RUN curl -L -o gradle.zip https://services.gradle.org/distributions/gradle-7.5-bin.zip && \
    unzip gradle.zip -d /opt && \
    rm gradle.zip
ENV GRADLE_HOME=/opt/gradle-7.5
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