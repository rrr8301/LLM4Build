# Dockerfile
FROM ubuntu:latest

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install system dependencies
RUN apt-get update && apt-get install -y \
    python3.12 \
    python3-pip \
    git

# Set up work directory
WORKDIR /app

# Copy repository contents
COPY . .

# Install Python dependencies
RUN pip3 install -r requirements-tests.txt

# Install Pydantic
RUN pip3 install "pydantic>=2.0.2,<3.0.0"

# Copy and set permissions for run.sh
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set entrypoint
ENTRYPOINT ["/app/run.sh"]