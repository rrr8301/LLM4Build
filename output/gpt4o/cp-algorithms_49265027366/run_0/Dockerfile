FROM ubuntu:latest

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    build-essential \
    python3.8 \
    python3-pip \
    && apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Set up work directory
WORKDIR /app

# Copy repository files
COPY . .

# Install Python dependencies
RUN pip3 install -r preview/requirements.txt

# Copy run.sh and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set entrypoint
ENTRYPOINT ["/app/run.sh"]