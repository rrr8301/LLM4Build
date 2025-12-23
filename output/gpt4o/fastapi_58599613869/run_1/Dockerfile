# Dockerfile
FROM ubuntu:latest

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install system dependencies
RUN apt-get update && apt-get install -y \
    python3.12 \
    python3-pip \
    python3.12-venv \
    git

# Set up work directory
WORKDIR /app

# Create and activate virtual environment
RUN python3.12 -m venv /app/venv
ENV PATH="/app/venv/bin:$PATH"

# Copy repository contents
COPY . .

# Install Python dependencies
RUN pip install -r requirements-tests.txt

# Install Pydantic
RUN pip install "pydantic>=2.0.2,<3.0.0"

# Copy and set permissions for run.sh
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set entrypoint
ENTRYPOINT ["/app/run.sh"]