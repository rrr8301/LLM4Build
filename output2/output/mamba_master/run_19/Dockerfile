# Dockerfile
FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install necessary packages and add PPA for Python 3.12
RUN apt-get update && apt-get install -y \
    software-properties-common \
    && add-apt-repository ppa:deadsnakes/ppa \
    && apt-get update && apt-get install -y \
    cmake \
    ninja-build \
    g++ \
    make \
    python3.12 \
    python3.12-venv \
    python3.12-dev \
    && apt-get clean

# Set up Python environment
RUN python3.12 -m ensurepip && python3.12 -m pip install --upgrade pip

# Create work directory
WORKDIR /app

# Copy only the requirements.txt first to leverage Docker cache
COPY requirements.txt /app/

# Ensure requirements.txt is present
RUN if [ ! -f /app/requirements.txt ]; then echo "requirements.txt not found"; exit 1; fi

# Install Python dependencies
RUN python3.12 -m pip install -r /app/requirements.txt

# Copy the rest of the repository contents
COPY . .

# Copy run.sh and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set entrypoint
ENTRYPOINT ["/app/run.sh"]