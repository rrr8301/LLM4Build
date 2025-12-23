# Use a Debian-based OpenJDK image that supports apt-get
FROM openjdk:17-jdk-slim

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install Maven
RUN apt-get update && apt-get install -y maven

# Create work directory
WORKDIR /app

# Copy the pom.xml and other necessary files into the container
COPY pom.xml /app/

# Copy the rest of the application source code
COPY src /app/src

# Copy run.sh and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set run.sh as the entrypoint
ENTRYPOINT ["/app/run.sh"]