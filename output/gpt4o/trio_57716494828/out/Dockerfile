FROM ubuntu:latest

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install dependencies
RUN apt-get update && \
    apt-get install -y software-properties-common && \
    add-apt-repository -y ppa:deadsnakes/ppa && \
    apt-get update && \
    apt-get install -y python3.11 python3.11-venv python3-pip python3-apport git && \
    apt-get clean

# Create work directory
WORKDIR /app

# Copy repository contents
COPY . .

# Install Python packages
RUN python3.11 -m venv venv && \
    . venv/bin/activate && \
    pip install --upgrade pip && \
    pip install tox

# Make all scripts executable
RUN chmod +x /app/run.sh && \
    chmod +x /app/ci.sh

# Set entrypoint
ENTRYPOINT ["/app/run.sh"]