# Use the Eclipse Temurin base image with Java 21
FROM eclipse-temurin:21-jdk

# Set the timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install Maven and other necessary tools
RUN apt-get update && \
    apt-get install -y maven && \
    apt-get clean

# Create a working directory
WORKDIR /app

# Copy the repository contents into the container
COPY . .

# Copy the run.sh script and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set the entrypoint to run.sh
ENTRYPOINT ["/app/run.sh"]