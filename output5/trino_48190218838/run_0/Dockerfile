FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install dependencies
RUN apt-get update && \
    apt-get install -y openjdk-24-jdk maven git && \
    apt-get clean

# Set environment variables
ENV MAVEN_OPTS="-Xmx512M -XX:+ExitOnOutOfMemoryError"
ENV MAVEN_INSTALL_OPTS="-Xmx3G -XX:+ExitOnOutOfMemoryError"
ENV MAVEN_FAST_INSTALL="-B -V -T 1C -DskipTests -Dmaven.source.skip=true -Dair.check.skip-all"
ENV MAVEN_TEST="-B -Dmaven.source.skip=true -Dair.check.skip-all --fail-at-end -P gib"

# Create work directory
WORKDIR /app

# Copy repository files
COPY . .

# Copy and set permissions for run.sh
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set entrypoint
ENTRYPOINT ["/app/run.sh"]