# Dockerfile
FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Set debconf to noninteractive
ENV DEBIAN_FRONTEND=noninteractive
ENV DEBCONF_NONINTERACTIVE_SEEN=true
ENV NEEDRESTART_MODE=a
ENV UCF_FORCE_CONFFNEW=1

# Install necessary packages including apt-utils for debconf
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    apt-utils \
    lsb-release \
    gcc make autoconf automake libtool pkg-config git sudo && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Create work directory
WORKDIR /app

# Copy the repository into the container
COPY . .

# Install build dependencies with non-interactive flags
RUN echo "grub-pc grub-pc/install_devices multiselect" | debconf-set-selections && \
    echo "grub-pc grub-pc/install_devices_empty boolean true" | debconf-set-selections && \
    echo "console-setup console-setup/charmap47 select UTF-8" | debconf-set-selections && \
    chmod +x scripts/install_xrdp_build_dependencies_with_apt.sh && \
    apt-get -y --allow-downgrades --allow-remove-essential --allow-change-held-packages \
        -o Dpkg::Options::="--force-confdef" \
        -o Dpkg::Options::="--force-confold" \
        -o DPkg::options::="--force-confnew" \
        -o Dpkg::Options::=--force-confnew \
        upgrade -y && \
    DEBIAN_FRONTEND=noninteractive DEBIAN_PRIORITY=critical \
    ./scripts/install_xrdp_build_dependencies_with_apt.sh max amd64 \
        --allow-downgrades \
        --allow-remove-essential \
        --allow-change-held-packages \
        -y --assume-yes --non-interactive