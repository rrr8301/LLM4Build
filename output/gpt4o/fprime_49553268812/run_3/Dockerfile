# Use Ubuntu 22.04 as the base image
FROM ubuntu:22.04

# Set the timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install OS-level dependencies
RUN apt-get update && apt-get install -y \
    git \
    python3 \
    python3-pip \
    python3-venv \
    build-essential \
    clang \
    gcc \
    g++ \
    cmake \
    ninja-build \
    && rm -rf /var/lib/apt/lists/*

# Set the working directory
WORKDIR /app

# Copy the repository into the container (submodules should be included in the copy)
COPY . .

# Initialize and update git submodules
RUN git submodule update --init --recursive

# Install Python dependencies
RUN pip3 install -r requirements.txt

# Make run.sh executable and set it as the entrypoint
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh
ENTRYPOINT ["/app/run.sh"]