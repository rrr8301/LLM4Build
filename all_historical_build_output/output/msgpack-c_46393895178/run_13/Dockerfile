# Use Ubuntu 22.04 as the base image
FROM ubuntu:22.04

# Set the timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install required packages
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    software-properties-common \
    wget \
    gnupg2 && \  # Use gnupg2 instead of gnupg
    wget -qO - https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x2C277A0A352154E5 | gpg --dearmor -o /etc/apt/trusted.gpg.d/ubuntu-toolchain-r.gpg && \
    echo "deb http://ppa.launchpad.net/ubuntu-toolchain-r/test/ubuntu jammy main" > /etc/apt/sources.list.d/ubuntu-toolchain-r.list && \
    apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    g++-10 \
    cmake \
    lcov \
    make \
    && rm -rf /var/lib/apt/lists/*

# Set the default compiler to g++-10
RUN update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-10 100

# Create a work directory
WORKDIR /app

# Copy the repository contents into the container
COPY . .

# Copy the run.sh script and make it executable
COPY run.sh /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh

# Set the entrypoint to run.sh
ENTRYPOINT ["/usr/local/bin/run.sh"]