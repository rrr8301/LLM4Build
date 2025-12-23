# Dockerfile
FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install necessary packages including git
RUN apt-get update && \
    apt-get install -y python3.11 python3.11-venv python3-pip git && \
    apt-get clean

# Upgrade pip and install required Python packages
RUN python3.11 -m pip install --upgrade pip && \
    pip install tox coverage

# Create work directory
WORKDIR /app

# Copy the repository into the container
COPY . .

# Ensure setup.py exists
RUN test -f /app/setup.py || (echo "setup.py not found" && exit 1)

# Copy the run.sh script and make it executable
COPY run.sh /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh

# Set the entrypoint to run.sh
ENTRYPOINT ["/usr/local/bin/run.sh"]