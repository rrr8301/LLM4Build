FROM ubuntu:latest

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    python3.11 \
    python3.11-venv \
    python3-pip \
    && apt-get clean

# Install uv
RUN pip install uv

# Create and set the working directory
WORKDIR /app

# Copy the repository contents into the container
COPY . .

# Install Python dependencies
RUN pip install tox

# Copy run.sh and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set the entrypoint
ENTRYPOINT ["/app/run.sh"]