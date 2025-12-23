# Use Ubuntu 24.04 as the base image
FROM ubuntu:24.04

# Set the timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install necessary packages
RUN apt-get update && apt-get install -y \
    curl \
    unzip \
    maven \
    && rm -rf /var/lib/apt/lists/*

# Set up Java (Zulu JDK 17)
RUN curl -sSL https://cdn.azul.com/zulu/bin/zulu17.32.13-ca-jdk17.0.2-linux_amd64.deb -o zulu-jdk.deb && \
    apt-get update && apt-get install -y ./zulu-jdk.deb && \
    rm zulu-jdk.deb

# Create a work directory
WORKDIR /app

# Copy the repository contents into the container
COPY . .

# Copy the run.sh script and make it executable
COPY run.sh /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh

# Set the entrypoint to run.sh
ENTRYPOINT ["/usr/local/bin/run.sh"]