# Use the latest Ubuntu as the base image
FROM ubuntu:latest

# Set the timezone to Pacific Time (America/Los_Angeles)
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install necessary packages
RUN apt-get update && \
    apt-get install -y openjdk-17-jdk maven git && \
    apt-get clean

# Set the working directory
WORKDIR /app

# Copy the repository into the container, including the .git directory
COPY . /app

# Ensure the mvnw script is executable
RUN chmod +x /app/mvnw

# Copy the run.sh script and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set the entrypoint to run.sh
ENTRYPOINT ["/app/run.sh"]