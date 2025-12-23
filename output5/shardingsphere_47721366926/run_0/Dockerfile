# Use Ubuntu 22.04 as the base image
FROM ubuntu:22.04

# Install required packages
RUN apt-get update && \
    apt-get install -y openjdk-11-jdk openjdk-8-jdk maven git && \
    apt-get clean

# Set environment variables
ENV MAVEN_OPTS="-Dhttp.keepAlive=false -Dmaven.wagon.http.pool=false -Dmaven.wagon.http.retryHandler.class=standard -Dmaven.wagon.http.retryHandler.count=3 -Dspotless.apply.skip=true"

# Create a working directory
WORKDIR /app

# Copy the repository into the container
COPY . .

# Copy the run.sh script and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set the entrypoint to run.sh
ENTRYPOINT ["/app/run.sh"]