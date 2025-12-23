# Use Ubuntu 22.04 as the base image
FROM ubuntu:22.04

# Set the timezone to Pacific Time (America/Los_Angeles)
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install necessary packages
RUN apt-get update && \
    apt-get install -y openjdk-17-jdk maven git && \
    apt-get clean

# Create a working directory
WORKDIR /app

# First copy only the Maven Wrapper files
COPY mvnw .
COPY .mvn .mvn

# Initialize Maven Wrapper first
RUN chmod +x mvnw && \
    ./mvnw -N io.takari:maven:wrapper -Dmaven=3.8.6

# Now copy the rest of the files
COPY . .

# Copy the run.sh script and make it executable
COPY run.sh /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh

# Set the entrypoint to run.sh
ENTRYPOINT ["/usr/local/bin/run.sh"]