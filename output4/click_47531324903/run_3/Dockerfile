FROM ubuntu:latest

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install system dependencies and add deadsnakes PPA for Python 3.13
RUN apt-get update && apt-get install -y \
    software-properties-common \
    git \
    curl \
    && add-apt-repository ppa:deadsnakes/ppa \
    && apt-get update && apt-get install -y \
    python3.13 \
    python3.13-venv \
    python3.13-dev \
    && apt-get clean

# Install pip for Python 3.13
RUN curl -sS https://bootstrap.pypa.io/get-pip.py | python3.13

# Create a working directory
WORKDIR /app

# Copy the repository into the container
COPY . /app

# Install Python dependencies
RUN pip install tox

# Copy run.sh and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set the entrypoint
ENTRYPOINT ["/app/run.sh"]