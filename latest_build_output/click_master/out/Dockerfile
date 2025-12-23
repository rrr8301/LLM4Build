FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install OS-level dependencies and add deadsnakes PPA for Python 3.12
RUN apt-get update && apt-get install -y \
    software-properties-common \
    && add-apt-repository ppa:deadsnakes/ppa \
    && apt-get update && apt-get install -y \
    git \
    curl \
    build-essential \
    python3.12 \
    python3.12-venv \
    python3.12-dev \
    && apt-get clean

# Set up Python environment
RUN update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.12 1
RUN curl -sS https://bootstrap.pypa.io/get-pip.py | python3.12

# Create and set work directory
WORKDIR /app

# Copy repository contents
COPY . .

# Install Python dependencies
RUN pip install uv tox

# Copy run.sh and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set entrypoint
ENTRYPOINT ["/app/run.sh"]