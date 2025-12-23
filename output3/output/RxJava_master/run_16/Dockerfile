# Use a Debian-based OpenJDK 17 as the base image
FROM openjdk:17-jdk-slim

# Set the timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install git and other necessary tools
RUN apt-get update && apt-get install -y git unzip && rm -rf /var/lib/apt/lists/*

# Create a work directory
WORKDIR /app

# Copy the repository into the container
COPY . .

# Make run.sh executable
RUN chmod +x /app/run.sh

# Set the entrypoint to run.sh
ENTRYPOINT ["/app/run.sh"]