# Use the base image
FROM ubuntu:22.04

# Set the timezone to Pacific Time (America/Los_Angeles)
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install any necessary dependencies (none specified, so this is a placeholder)
RUN apt-get update && apt-get install -y \
    # Add any required packages here
    && rm -rf /var/lib/apt/lists/*

# Create a working directory
WORKDIR /app

# Copy the repository contents into the container
COPY . .

# Copy the run.sh script and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set the entrypoint to run.sh
ENTRYPOINT ["/app/run.sh"]