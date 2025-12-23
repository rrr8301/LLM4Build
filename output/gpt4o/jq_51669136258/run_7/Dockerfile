# Use Ubuntu 24.04 as the base image
FROM ubuntu:24.04

# Set the timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install required packages
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    automake autoconf libtool crossbuild-essential-amd64 \
    make gcc git pkg-config && \
    rm -rf /var/lib/apt/lists/*

# Create a working directory
WORKDIR /app

# Copy the repository into the container including .git directory
COPY . .

# Initialize and update submodules
RUN if [ -d .git ]; then \
        git submodule update --init --recursive; \
    fi

# Fix permissions for scripts
RUN chmod +x scripts/*

# Verify configure.ac exists before running autoreconf
RUN if [ ! -f "configure.ac" ]; then \
        echo "Error: configure.ac not found in root directory"; \
        exit 1; \
    fi

# Copy the run.sh script and make it executable
COPY run.sh /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh

# Set the entrypoint to run.sh
ENTRYPOINT ["/usr/local/bin/run.sh"]