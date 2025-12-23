FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install dependencies
RUN apt-get update && apt-get install -y \
    gcc \
    clang \
    python3-pip \
    ninja-build \
    libx11-dev \
    libxrandr-dev \
    libxext-dev \
    libasound2-dev \
    libpulse-dev \
    libvdpau-dev \
    libgl1-mesa-dev \
    libegl1-mesa-dev \
    libxv-dev \
    zlib1g-dev \
    libass-dev \
    liblua5.2-dev \
    libjpeg-dev \
    libuchardet-dev \
    libva-dev \
    libva-glx2 \
    libva-drm2 \
    pkg-config \
    wget \
    yasm \
    && rm -rf /var/lib/apt/lists/*

# Install the latest version of Meson using pip
RUN pip3 install --upgrade meson

# Build and install FFmpeg from source to get the required version of libavcodec
RUN mkdir -p /tmp/ffmpeg && \
    cd /tmp/ffmpeg && \
    wget https://ffmpeg.org/releases/ffmpeg-6.1.tar.bz2 && \  # Update to a newer version
    tar xjf ffmpeg-6.1.tar.bz2 && \  # Update to a newer version
    cd ffmpeg-6.1 && \  # Update to a newer version
    ./configure --prefix=/usr/local --enable-shared --disable-static && \
    make -j$(nproc) && \
    make install && \
    ldconfig && \
    cd / && \
    rm -rf /tmp/ffmpeg

# Create work directory
WORKDIR /app

# Copy repository contents
COPY . .

# Copy run.sh and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set entrypoint
ENTRYPOINT ["/app/run.sh"]