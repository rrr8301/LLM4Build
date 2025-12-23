FROM ubuntu:latest

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install dependencies including sudo, GLEW and libusb-1.0
RUN apt-get update && apt-get install -y \
    sudo \
    cmake \
    make \
    g++ \
    git \
    pkg-config \
    libgtk-3-dev \
    libgl1-mesa-dev \
    libglu1-mesa-dev \
    libwxgtk3.2-dev \
    libglew-dev \
    libarchive-dev \
    libtinyxml2-dev \
    libudev-dev \
    libbz2-dev \
    zlib1g-dev \
    libx11-dev \
    libxext-dev \
    libshp-dev \
    libssl-dev \
    libsqlite3-dev \
    libsndfile1-dev \
    libcurl4-openssl-dev \
    libjpeg-dev \
    libharfbuzz-dev \
    libpango1.0-dev \
    libusb-1.0-0-dev \
    dbus \
    xvfb \
    && rm -rf /var/lib/apt/lists/*

# Create work directory
WORKDIR /app

# Copy repository contents
COPY . .

# Make scripts executable
RUN chmod +x /app/ci/github-pre-build.sh && \
    chmod +x /app/run.sh

# Set entrypoint
ENTRYPOINT ["/app/run.sh"]