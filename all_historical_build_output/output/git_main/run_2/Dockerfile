# Use Ubuntu as the base image
FROM ubuntu:22.04

# Set the timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install necessary packages
RUN apt-get update && apt-get install -y \
    build-essential \
    libssl-dev \
    libcurl4-gnutls-dev \
    libexpat1-dev \
    gettext \
    unzip \
    autoconf \
    zlib1g-dev \  # Added zlib1g-dev to install zlib development files
    && rm -rf /var/lib/apt/lists/*

# Create a working directory
WORKDIR /usr/src/git

# Copy the repository contents into the container
COPY . .

# Copy the run.sh script and make it executable
COPY run.sh /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh

# Set the entrypoint to run.sh
ENTRYPOINT ["/usr/local/bin/run.sh"]