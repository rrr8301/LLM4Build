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
    python3.8-venv \
    && apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Set up work directory
WORKDIR /app

# Create and activate virtual environment
RUN python3.8 -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

# Copy repository files
COPY . .

# Install Python dependencies
RUN pip install -r preview/requirements.txt

# Copy run.sh and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set entrypoint
ENTRYPOINT ["/app/run.sh"]