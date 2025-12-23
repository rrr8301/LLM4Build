# Dockerfile
FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install system dependencies
RUN apt-get update && \
    apt-get install -y python3.10 python3.10-venv python3-pip git && \
    apt-get clean

# Set up work directory
WORKDIR /app

# Copy the repository
COPY . .

# Install Python dependencies
RUN python3.10 -m pip install --upgrade pip setuptools && \
    python3.10 -m pip install -r requirements.txt --progress-bar off --upgrade && \
    python3.10 -m pip uninstall -y keras keras-nightly && \
    python3.10 -m pip install -e "." --progress-bar off --upgrade

# Copy run.sh and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set entrypoint
ENTRYPOINT ["/app/run.sh"]