# Dockerfile
FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install Python 3.12, pip, and other necessary packages
RUN apt-get update && \
    apt-get install -y software-properties-common && \
    add-apt-repository ppa:deadsnakes/ppa && \
    apt-get update && \
    apt-get install -y python3.12 python3.12-venv python3.12-dev curl && \
    curl -sS https://bootstrap.pypa.io/get-pip.py | python3.12 && \
    apt-get clean

# Create a working directory
WORKDIR /app

# Copy the repository into the container
COPY . .

# Ensure requirements.txt is present
RUN test -f requirements.txt || (echo "requirements.txt not found!" && exit 1)

# Install Python dependencies
RUN python3.12 -m pip install --upgrade pip && \
    python3.12 -m pip install -r requirements.txt

# Copy run.sh and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set the entrypoint
ENTRYPOINT ["/app/run.sh"]