# Use the base image
FROM ubuntu:22.04

# Set the timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install necessary packages
RUN apt-get update && apt-get install -y \
    curl \
    unzip \
    && rm -rf /var/lib/apt/lists/*

# Set up JDK 17 (temurin)
RUN curl -fsSL https://api.adoptopenjdk.net/v3/binary/latest/17/ga/linux/x64/jdk/hotspot/normal/adoptopenjdk \
    -o /tmp/openjdk17.tar.gz && \
    mkdir -p /opt/openjdk && \
    tar -xzf /tmp/openjdk17.tar.gz -C /opt/openjdk && \
    rm /tmp/openjdk17.tar.gz
ENV JAVA_HOME=/opt/openjdk
ENV PATH="$JAVA_HOME/bin:$PATH"

# Install Gradle
RUN curl -s "https://get.sdkman.io" | bash && \
    bash -c "source $HOME/.sdkman/bin/sdkman-init.sh && sdk install gradle"

# Create work directory
WORKDIR /app

# Copy the repository
COPY . .

# Copy run.sh and make it executable
COPY run.sh /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh

# Set the entrypoint
ENTRYPOINT ["/usr/local/bin/run.sh"]