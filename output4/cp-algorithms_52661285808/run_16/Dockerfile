FROM ubuntu:latest

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    build-essential \
    software-properties-common && \
    add-apt-repository ppa:deadsnakes/ppa && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
    python3.8 \
    python3.8-venv \
    python3-pip \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Set up work directory
WORKDIR /app

# Copy repository contents
COPY . .

# Fix the requirements.txt file
RUN sed -i 's/watchdog==2.1./watchdog==2.1.0/' preview/requirements.txt

# Create a virtual environment and install Python dependencies
RUN python3.8 -m venv venv && \
    . venv/bin/activate && \
    pip install --upgrade pip && \
    pip install -r preview/requirements.txt

# Copy run.sh and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Ensure test.sh is executable
RUN chmod +x test/test.sh

# Set entrypoint
ENTRYPOINT ["/app/run.sh"]