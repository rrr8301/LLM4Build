FROM eclipse-temurin:8-jdk

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install necessary packages
RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    wget \
    unzip \
    && rm -rf /var/lib/apt/lists/*

# Install Gradle
RUN wget https://services.gradle.org/distributions/gradle-7.2-bin.zip && \
    unzip gradle-7.2-bin.zip -d /opt && \
    ln -s /opt/gradle-7.2/bin/gradle /usr/bin/gradle && \
    rm gradle-7.2-bin.zip

# Create work directory
WORKDIR /app

# Copy repository
COPY . .

# Ensure gradlew is executable
RUN chmod +x ./gradlew

# Copy run.sh and make it executable
COPY run.sh /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh

# Set entrypoint
ENTRYPOINT ["/usr/local/bin/run.sh"]