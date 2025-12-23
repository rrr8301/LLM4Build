FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install system dependencies and add deadsnakes PPA for Python 3.9
RUN apt-get update && apt-get install -y \
    software-properties-common \
    && add-apt-repository ppa:deadsnakes/ppa \
    && apt-get update && apt-get install -y \
    python3.9 \
    python3.9-venv \
    python3-pip \
    git \
    && apt-get clean

# Install Python packages
RUN pip install --upgrade pip setuptools wheel pipenv

# Create work directory
WORKDIR /app

# Copy repository files
COPY . .

# Install project dependencies
RUN pip install -e .[safety] --upgrade
RUN pipenv install --deploy --dev --python=3.9

# Install additional Python packages
RUN pip install gunicorn pypiserver==2.3.2

# Copy run.sh and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set entrypoint
ENTRYPOINT ["/app/run.sh"]