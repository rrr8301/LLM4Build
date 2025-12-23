FROM ubuntu:latest

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install dependencies
RUN apt-get update && \
    apt-get install -y python3.12 python3.12-venv python3-pip python3-apport git && \
    apt-get clean

# Create work directory
WORKDIR /app

# Copy repository contents
COPY . .

# Make scripts executable
RUN chmod +x /app/run.sh && \
    chmod +x /app/ci.sh

# Set entrypoint
ENTRYPOINT ["/app/run.sh"]