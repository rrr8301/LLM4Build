# Use the official Ubuntu 22.04 base image
FROM ubuntu:22.04

# Set the working directory
WORKDIR /app

# Install dependencies
RUN apt-get update && \
    apt-get install -y python3 python3-pip && \
    apt-get clean

# Copy the current directory contents into the container at /app
COPY . .

# Install Python packages
RUN python3 -m pip install pre-commit==2.20.0 && \
    python3 -m pip install black==23.3.0 && \
    python3 -m pip install ruff==0.0.263 && \
    python3 -m pip install pytest==7.4.0 pytest-cov && \
    python3 -m pip install mypy==1.5.0

# Copy the run.sh script and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set the entrypoint to the run.sh script
ENTRYPOINT ["/app/run.sh"]