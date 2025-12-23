# Use Ubuntu 22.04 as the base image
FROM ubuntu:22.04

# Set the timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    gcc \
    make \
    cmake \
    clang \
    git \
    libboost-all-dev \  # Install Boost libraries
    zlib1g-dev \        # Install Zlib for compression support
    && rm -rf /var/lib/apt/lists/*

# Create work directory
WORKDIR /app

# Copy the repository into the container
COPY . .

# Ensure CMakeLists.txt or configure.ac is used to generate a Makefile
RUN if [ -f CMakeLists.txt ]; then \
      cmake .; \
    elif [ -f configure.ac ]; then \
      ./configure; \
    fi

# Copy run.sh, make it executable, and set as entrypoint
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh
ENTRYPOINT ["/app/run.sh"]