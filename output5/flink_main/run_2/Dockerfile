# Use the base image
FROM ubuntu:22.04

# Set the working directory
WORKDIR /app

# Install dependencies
RUN apt-get update && \
    apt-get install -y git maven openjdk-17-jdk curl && \
    apt-get clean

# Copy the current directory to the working directory
COPY . .

# Make run.sh executable
RUN chmod +x /app/run.sh

# Set environment variable for debugging files output directory
ENV DEBUG_FILES_OUTPUT_DIR=/app/debug_output

# Create the debug output directory
RUN mkdir -p $DEBUG_FILES_OUTPUT_DIR

# Set the entrypoint
ENTRYPOINT ["/app/run.sh"]