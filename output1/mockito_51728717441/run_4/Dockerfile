# Use Ubuntu as the base image
FROM ubuntu:latest

# Set the timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install necessary packages
RUN apt-get update && apt-get install -y \
    curl \
    unzip \
    git \
    zip && \
    rm -rf /var/lib/apt/lists/*

# Install Java 17
RUN apt-get update && apt-get install -y openjdk-17-jdk && \
    rm -rf /var/lib/apt/lists/*

# Install SDKMAN and Gradle
RUN curl -s "https://get.sdkman.io" | bash && \
    bash -c "source $HOME/.sdkman/bin/sdkman-init.sh && sdk install gradle"

# Create work directory
WORKDIR /app

# Copy the repository into the container
COPY . .

# Ensure gradlew and other scripts are executable
RUN chmod +x ./gradlew
RUN chmod +x ./check_reproducibility.sh

# Copy run.sh and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set the entrypoint
ENTRYPOINT ["/app/run.sh"]