FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Set non-interactive frontend for debconf
ENV DEBIAN_FRONTEND=noninteractive

# Install OS-level dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    libhdf5-dev \
    software-properties-common \
    wget \
    gnupg && \  # Corrected package name from gnupg2 to gnupg
    wget -qO - https://keyserver.ubuntu.com/pks/lookup?op=get&search=0xBA6932366A755776 | gpg --dearmor -o /usr/share/keyrings/deadsnakes-archive-keyring.gpg && \
    echo "deb [signed-by=/usr/share/keyrings/deadsnakes-archive-keyring.gpg] http://ppa.launchpad.net/deadsnakes/ppa/ubuntu jammy main" > /etc/apt/sources.list.d/deadsnakes-ppa.list && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
    python3.11 \
    python3.11-venv \
    python3.11-dev \
    python3-pip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Create and set the working directory
WORKDIR /app

# Copy the repository contents into the container
COPY . .

# Install Python dependencies using uv
RUN pip install --upgrade pip && \
    pip install uv

# Copy run.sh and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set the entrypoint to run.sh
ENTRYPOINT ["/app/run.sh"]