FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install necessary packages
RUN apt-get update && apt-get install -y \
    curl \
    unzip \
    && rm -rf /var/lib/apt/lists/*

# Set up Java
RUN curl -s "https://api.adoptopenjdk.net/v3/binary/latest/21/ga/linux/x64/jdk/openj9/normal/adoptopenjdk" -L -o openjdk.tar.gz \
    && mkdir -p /opt/java/openjdk \
    && tar -xzf openjdk.tar.gz -C /opt/java/openjdk --strip-components=1 \
    && rm openjdk.tar.gz
ENV JAVA_HOME=/opt/java/openjdk
ENV PATH="$JAVA_HOME/bin:$PATH"

# Create work directory
WORKDIR /app

# Copy repository files
COPY . .

# Copy and set run.sh as entrypoint
COPY run.sh /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh
ENTRYPOINT ["/usr/local/bin/run.sh"]