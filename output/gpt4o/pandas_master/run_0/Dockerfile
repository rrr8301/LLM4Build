# Dockerfile
FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install Python 3.12 and pip
RUN apt-get update && \
    apt-get install -y python3.12 python3-pip tzdata && \
    apt-get clean

# Set work directory
WORKDIR /app

# Copy the repository
COPY . .

# Install Python dependencies
RUN python3.12 -m pip install --upgrade pip && \
    pip install -r requirements.txt

# Copy run.sh and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set entrypoint
ENTRYPOINT ["/app/run.sh"]