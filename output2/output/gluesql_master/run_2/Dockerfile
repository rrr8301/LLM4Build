# Use a Debian-based OpenJDK image that supports apt-get
FROM openjdk:17-jdk-slim

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install Maven
RUN apt-get update && apt-get install -y maven

# Create work directory
WORKDIR /app

# Copy the repository into the container
# Ensure the pom.xml is in the root of the context being copied
COPY . /app

# Copy run.sh and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set run.sh as the entrypoint
ENTRYPOINT ["/app/run.sh"]