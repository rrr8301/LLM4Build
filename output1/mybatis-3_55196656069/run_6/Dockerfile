# Dockerfile
FROM ubuntu:latest

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install necessary packages
RUN apt-get update && apt-get install -y \
    curl \
    unzip \
    maven \
    && rm -rf /var/lib/apt/lists/*

# Set up JDK 21
RUN curl -L -o jdk.tar.gz https://download.oracle.com/java/21/latest/jdk-21_linux-x64_bin.tar.gz && \
    mkdir -p /usr/lib/jvm && \
    tar -xzf jdk.tar.gz -C /usr/lib/jvm && \
    rm jdk.tar.gz && \
    JDK_DIR=$(ls /usr/lib/jvm | grep jdk-21) && \
    mv /usr/lib/jvm/$JDK_DIR /usr/lib/jvm/jdk-21

# Update alternatives to ensure javac is available
RUN update-alternatives --install /usr/bin/java java /usr/lib/jvm/jdk-21/bin/java 1 && \
    update-alternatives --install /usr/bin/javac javac /usr/lib/jvm/jdk-21/bin/javac 1

ENV JAVA_HOME=/usr/lib/jvm/jdk-21
ENV PATH="$JAVA_HOME/bin:$PATH"

# Verify Java installation
RUN java -version && javac -version

# Create work directory
WORKDIR /app

# Copy repository contents
COPY . .

# Copy run.sh and make it executable
COPY run.sh /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh

# Set entrypoint
ENTRYPOINT ["/usr/local/bin/run.sh"]