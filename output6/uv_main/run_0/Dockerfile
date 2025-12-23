# Dockerfile
FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install Python and other dependencies
RUN apt-get update && \
    apt-get install -y python3.12 python3.12-venv python3.12-dev python3-pip && \
    apt-get clean

# Create a working directory
WORKDIR /app

# Copy the repository contents
COPY . .

# Install Python dependencies
RUN pip install -r requirements.txt

# Copy the run.sh script and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set the entrypoint
ENTRYPOINT ["/app/run.sh"]