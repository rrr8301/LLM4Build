# Dockerfile
FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Set debconf to noninteractive
ENV DEBIAN_FRONTEND=noninteractive

# Install necessary packages including apt-utils for debconf
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    apt-utils \
    gcc make autoconf automake libtool pkg-config git sudo && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Create work directory
WORKDIR /app

# Copy the repository into the container
COPY . .

# Install build dependencies
RUN echo "grub-pc grub-pc/install_devices multiselect" | debconf-set-selections && \
    echo "grub-pc grub-pc/install_devices_empty boolean true" | debconf-set-selections && \
    sudo scripts/install_xrdp_build_dependencies_with_apt.sh max amd64 --allow-downgrades --allow-remove-essential --allow-change-held-packages

# Copy run.sh and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set entrypoint
ENTRYPOINT ["/app/run.sh"]