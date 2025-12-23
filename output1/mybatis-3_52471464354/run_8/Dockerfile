# Use the latest Ubuntu as the base image
FROM ubuntu:latest

# Set the timezone to Pacific Time (America/Los_Angeles)
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install necessary packages
RUN apt-get update && apt-get install -y \
    curl \
    unzip \
    maven \
    file \
    && rm -rf /var/lib/apt/lists/*

# Set up JDK 21 (temurin)
RUN curl -L -o /tmp/openjdk.tar.gz https://github.com/adoptium/temurin21-binaries/releases/download/jdk-21.0.0+35/OpenJDK21U-jdk_x64_linux_hotspot_21.0.0_35.tar.gz \
    && if [ "$(file -b --mime-type /tmp/openjdk.tar.gz)" = "application/gzip" ]; then \
        mkdir -p /opt/java/openjdk && \
        tar -xzf /tmp/openjdk.tar.gz -C /opt/java/openjdk --strip-components=1; \
    else \
        echo "Downloaded file is not a valid gzip archive"; \
        exit 1; \
    fi \
    && rm /tmp/openjdk.tar.gz

ENV JAVA_HOME=/opt/java/openjdk
ENV PATH="$JAVA_HOME/bin:$PATH"

# Create a work directory
WORKDIR /app

# Copy the repository into the container
COPY . .

# Copy the run.sh script and make it executable
COPY run.sh /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh

# Set the entrypoint to run.sh
ENTRYPOINT ["/usr/local/bin/run.sh"]