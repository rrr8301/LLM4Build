FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install system dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    python3 \
    python3-pip \
    build-essential \
    sudo \
    git \
    curl \
    wget && \
    rm -rf /var/lib/apt/lists/*

# Create work directory
WORKDIR /app

# Copy the repository
COPY . .

# Install Python dependencies if any
# Uncomment the following line if you have a requirements.txt
# RUN pip3 install -r requirements.txt

# Make run.sh executable and set as entrypoint
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh
ENTRYPOINT ["/app/run.sh"]