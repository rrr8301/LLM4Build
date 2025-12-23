# Use a valid base image
FROM ubuntu:22.04

# Install required packages
RUN apt-get update && \
    apt-get install -y curl maven && \
    rm -rf /var/lib/apt/lists/*

# Set up Zulu JDK 21
RUN curl -sSL https://cdn.azul.com/zulu/bin/zulu21.32.11-ca-jdk21.0.0-linux_amd64.deb -o zulu-jdk.deb && \
    apt-get install -y ./zulu-jdk.deb && \
    apt-get install -f -y && \
    rm zulu-jdk.deb

# Set environment variables
ENV JAVA_HOME=/usr/lib/jvm/zulu-21-amd64
ENV PATH="$JAVA_HOME/bin:$PATH"
ENV JAVA_TOOL_OPTIONS="-Dfile.encoding=UTF-8 -Duser.timezone=Asia/Shanghai"

# Create work directory
WORKDIR /app

# Copy the repository into the container
COPY . .

# Copy the run.sh script and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set the entrypoint
ENTRYPOINT ["/app/run.sh"]