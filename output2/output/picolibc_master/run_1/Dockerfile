# Dockerfile
FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -fs /usr/share/zoneinfo/$TZ /etc/localtime && \
    apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y tzdata

# Install required packages
RUN apt-get update && \
    apt-get install -y wget tar docker.io ccache

# Create work directory
WORKDIR /picolibc

# Copy repository
COPY . .

# Install ccache
RUN wget -nv https://github.com/ccache/ccache/releases/download/v4.8.2/ccache-4.8.2-linux-x86_64.tar.xz && \
    tar xf ccache-4.8.2-linux-x86_64.tar.xz -C /usr/bin --strip-components=1 --no-same-owner ccache-4.8.2-linux-x86_64/ccache && \
    rm -f ccache-*-linux-x86_64.tar.xz

# Ensure dockerimg-zephyr.tar.zst is copied
COPY dockerimg-zephyr.tar.zst /picolibc/

# Copy run.sh, make it executable and set as entrypoint
COPY run.sh /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh
ENTRYPOINT ["/usr/local/bin/run.sh"]