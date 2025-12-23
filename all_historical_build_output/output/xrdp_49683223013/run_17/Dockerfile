# Dockerfile
FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install required packages
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    gcc make autoconf automake libtool pkg-config \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Create work directory
WORKDIR /app

# Copy repository files
COPY . .

# Install dependencies using the provided script
RUN scripts/install_xrdp_build_dependencies_with_apt.sh max amd64 --allow-downgrades --allow-remove-essential --allow-change-held-packages

# Ensure all necessary directories and files are present
RUN mkdir -p ulalaca && touch ulalaca/Makefile.am

# Ensure m4 directory exists
RUN mkdir -p m4

# Copy run.sh and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set entrypoint
ENTRYPOINT ["/app/run.sh"]