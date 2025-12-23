FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install dependencies
RUN apt-get update && apt-get install -y \
    gcc \
    clang \
    meson \
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
    libavutil-dev \
    libavcodec-dev \
    libavformat-dev \
    libswscale-dev \
    libavfilter-dev \
    libswresample-dev \
    libplacebo-dev \
    zlib1g-dev \
    libass-dev \
    liblua5.2-dev \
    libjpeg-dev \
    libuchardet-dev \
    libva-dev \
    libva-glx2 \
    libva-drm2 \
    && rm -rf /var/lib/apt/lists/*

# Create work directory
WORKDIR /app

# Copy repository contents
COPY . .

# Copy run.sh and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set entrypoint
ENTRYPOINT ["/app/run.sh"]