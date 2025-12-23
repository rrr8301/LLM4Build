FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install dependencies
RUN apt-get update && apt-get install -y \
    git \
    cmake \
    python3.9 \
    python3.9-venv \
    python3-pip \
    && apt-get clean

# Create work directory
WORKDIR /app

# Copy repository contents
COPY . .

# Install Python packages
RUN pip3 install fprime-bootstrap pytest

# Copy run.sh and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set entrypoint
ENTRYPOINT ["/app/run.sh"]