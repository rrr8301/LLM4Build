# Use Docker's official DinD image as the base image
FROM docker:20.10.24-dind

# Set the timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN apk add --no-cache tzdata && \
    cp /usr/share/zoneinfo/$TZ /etc/localtime && \
    echo $TZ > /etc/timezone

# Install necessary packages
RUN apk add --no-cache openjdk17 gradle jq curl

# Create a working directory
WORKDIR /app

# Copy the repository contents into the container
COPY . .

# Copy the run.sh script and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set the entrypoint to run.sh
ENTRYPOINT ["/app/run.sh"]