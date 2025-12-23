FROM ubuntu:22.04

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

# Set up the working directory
WORKDIR /app

# Copy the repository content
COPY . .

# Install Python dependencies
RUN python3.11 -m pip install --upgrade pip setuptools
RUN python3.11 -m pip install -e .[test]

# Copy the run.sh script and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set the entrypoint
ENTRYPOINT ["/app/run.sh"]