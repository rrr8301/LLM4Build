FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install Python 3.10 and other dependencies
RUN apt-get update && \
    apt-get install -y python3.10 python3.10-venv python3-pip && \
    apt-get clean

# Set up work directory
WORKDIR /app

# Copy the repository contents
COPY . .

# Install Python dependencies
RUN python3.10 -m venv venv && \
    . venv/bin/activate && \
    pip install --upgrade pip && \
    pip install -r requirements.txt

# Ensure tox is installed
RUN . venv/bin/activate && \
    pip install tox

# Copy run.sh and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set entrypoint
ENTRYPOINT ["/app/run.sh"]