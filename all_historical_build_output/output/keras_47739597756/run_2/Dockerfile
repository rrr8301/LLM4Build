# Dockerfile
FROM ubuntu:22.04

# Install system dependencies
RUN apt-get update && \
    apt-get install -y python3.10 python3-pip git dos2unix && \
    apt-get clean

# Set the working directory
WORKDIR /app

# Copy the repository content
COPY . .

# Install Python dependencies
RUN pip3 install --upgrade pip setuptools && \
    pip3 install -r requirements.txt --progress-bar off --upgrade && \
    pip3 uninstall -y keras keras-nightly && \
    pip3 install -e "." --progress-bar off --upgrade

# Copy the run.sh script and make it executable
COPY run.sh /app/run.sh
RUN dos2unix /app/run.sh && chmod +x /app/run.sh

# Set the entrypoint
ENTRYPOINT ["/app/run.sh"]