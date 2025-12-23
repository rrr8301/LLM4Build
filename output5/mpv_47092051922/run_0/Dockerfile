FROM ubuntu:22.04

# Install dependencies
RUN apt-get update && apt-get install -y \
    gcc g++ meson ninja-build pkg-config \
    libx11-dev libxrandr-dev libxext-dev libxv-dev \
    libasound2-dev libpulse-dev libvdpau-dev \
    libgl1-mesa-dev libegl1-mesa-dev \
    libavutil-dev libavcodec-dev libavformat-dev \
    libswscale-dev libavfilter-dev libswresample-dev \
    libass-dev libplacebo-dev zlib1g-dev \
    libjpeg-dev libuchardet-dev liblua5.2-dev \
    nasm libfreetype6-dev libfontconfig1-dev \
    libfribidi-dev libharfbuzz-dev libssl-dev \
    libgnutls28-dev libx264-dev libmp3lame-dev \
    libfdk-aac-dev libxml2-dev libdav1d-dev \
    nv-codec-headers git

# Copy the repository
COPY . /app
WORKDIR /app

# Copy run.sh and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set the entrypoint
ENTRYPOINT ["/app/run.sh"]