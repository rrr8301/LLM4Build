FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -fs /usr/share/zoneinfo/$TZ /etc/localtime && \
    apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y tzdata

# Install dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    python3 \
    python3-pip \
    sudo \
    build-essential

# Create work directory
WORKDIR /app

# Copy repository files
COPY . .

# Install system dependencies using the provided Python script
RUN sudo --preserve-env=http_proxy python3 build/fbcode_builder/getdeps.py --allow-system-packages install-system-deps --recursive proxygen && \
    sudo --preserve-env=http_proxy python3 build/fbcode_builder/getdeps.py --allow-system-packages install-system-deps --recursive patchelf

# Copy run.sh, make it executable, and set as entrypoint
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh
ENTRYPOINT ["/app/run.sh"]