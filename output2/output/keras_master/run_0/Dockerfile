# Dockerfile
FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install OS-level dependencies
RUN apt-get update && \
    apt-get install -y python3.11 python3.11-venv python3-pip tzdata && \
    apt-get clean

# Set up the working directory
WORKDIR /app

# Copy the repository contents
COPY . .

# Install Python dependencies
RUN python3.11 -m pip install --upgrade pip setuptools && \
    pip install -r requirements.txt --progress-bar off --upgrade && \
    pip install --upgrade 'flax>=0.11.1' && \
    pip uninstall -y keras keras-nightly && \
    pip install -e "." --progress-bar off --upgrade

# Copy the run.sh script and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set the entrypoint
ENTRYPOINT ["/app/run.sh"]