# Dockerfile
FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install system dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    python3 python3-venv python3-pip make dos2unix && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Set up the working directory
WORKDIR /app

# Copy the repository content
COPY . .

# Ensure run.sh has the correct line endings
RUN dos2unix run.sh

# Make run.sh executable
RUN chmod +x run.sh

# Set the entrypoint
ENTRYPOINT ["/app/run.sh"]