# Use the official Ubuntu base image
FROM ubuntu:latest

# Set the timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install system dependencies
RUN apt-get update && apt-get install -y \
    curl \
    wget \
    git \
    build-essential \
    python3.9 \
    python3.10 \
    python3.11 \
    python3.14 \
    python3-pip

# Install uv and conda for Python 3.14
RUN pip install uv
RUN curl -fsSL https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -o miniconda.sh && \
    bash miniconda.sh -b -p /opt/conda && \
    rm miniconda.sh && \
    /opt/conda/bin/conda init

# Create a working directory
WORKDIR /app

# Copy the repository contents into the container
COPY . .

# Install Python dependencies
RUN pip install nox pytest flake8

# Copy the run.sh script and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set the entrypoint to run.sh
ENTRYPOINT ["/app/run.sh"]