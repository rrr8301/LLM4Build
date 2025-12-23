# Dockerfile
FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install necessary packages
RUN apt-get update && apt-get install -y \
    wget \
    curl \
    unzip \
    openjdk-17-jdk \
    maven \
    && rm -rf /var/lib/apt/lists/*

# Create work directory
WORKDIR /app

# Copy the repository into the container
COPY . .

# Run the driver download script
RUN chmod +x scripts/download_driver.sh && ./scripts/download_driver.sh

# Build and install the project
RUN mvn -B install -D skipTests --no-transfer-progress

# Install browsers using Playwright
RUN mvn exec:java -e -D exec.mainClass=com.microsoft.playwright.CLI -D exec.args="install --with-deps" -f playwright/pom.xml --no-transfer-progress

# Copy run.sh and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set the entrypoint
ENTRYPOINT ["/app/run.sh"]