FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install dependencies
RUN apt-get update && apt-get install -y \
    gcc g++ meson ninja-build pkg-config \
    libx11-dev libxrandr-dev libxext-dev libxv-dev \
    libasound2-dev libpulse-dev libvdpau-dev \
    libgl1-mesa-dev libegl1-mesa-dev libass-dev \
    libjpeg-dev libuchardet-dev libplacebo-dev \
    libavutil-dev libavcodec-dev libavformat-dev \
    libswscale-dev libavfilter-dev libswresample-dev \
    zlib1g-dev libiconv-hook-dev liblua5.2-dev \
    libfribidi-dev libfreetype6-dev libfontconfig1-dev \
    libharfbuzz-dev nasm libssl-dev libgnutls28-dev \
    libx264-dev libmp3lame-dev libfdk-aac-dev \
    libxml2-dev libdav1d-dev nv-codec-headers \
    && rm -rf /var/lib/apt/lists/*

# Create work directory
WORKDIR /app

# Copy repository
COPY . .

# Copy run.sh and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set entrypoint
ENTRYPOINT ["/app/run.sh"]