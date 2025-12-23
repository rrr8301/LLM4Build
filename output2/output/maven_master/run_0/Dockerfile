FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install dependencies
RUN apt-get update && \
    apt-get install -y openjdk-17-jdk maven && \
    apt-get clean

# Create work directory
WORKDIR /app

# Copy repository contents
COPY . .

# Prepare Mimir for Maven
RUN mkdir -p ~/.mimir && \
    cp .github/ci-mimir-session.properties ~/.mimir/session.properties && \
    cp .github/ci-mimir-daemon.properties ~/.mimir/daemon.properties && \
    cp .github/ci-extensions.xml .mvn/extensions.xml

# Set up Maven
RUN mvn --errors --batch-mode --show-version org.apache.maven.plugins:maven-wrapper-plugin:3.3.4:wrapper "-Dmaven=4.0.0-rc-4"

# Copy run.sh and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set entrypoint
ENTRYPOINT ["/app/run.sh"]