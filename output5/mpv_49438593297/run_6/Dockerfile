FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Use a different mirror and add a retry mechanism
RUN sed -i 's|http://archive.ubuntu.com/ubuntu/|http://mirror.math.princeton.edu/pub/ubuntu/|g' /etc/apt/sources.list && \
    apt-get update || (sleep 30 && apt-get update) && \
    apt-get install -y --no-install-recommends \
    software-properties-common python3-pip git && \
    add-apt-repository universe && \
    apt-get update || (sleep 30 && apt-get update) && \
    apt-get install -y --no-install-recommends \
    gcc g++ ninja-build pkg-config \
    libx11-dev libxrandr-dev libxext-dev libxv-dev \
    libasound2-dev libpulse-dev libvdpau-dev \
    libgl1-mesa-dev libegl1-mesa-dev libass-dev \
    libjpeg-turbo8-dev libuchardet-dev libplacebo-dev \
    zlib1g-dev liblua5.2-dev \
    libfribidi-dev libfreetype6-dev libfontconfig1-dev \
    libharfbuzz-dev nasm libssl-dev libgnutls28-dev \
    libx264-dev libmp3lame-dev libfdk-aac-dev \
    libxml2-dev libdav1d-dev cmake \
    && rm -rf /var/lib/apt/lists/*

# Install the latest version of Meson using pip
RUN pip3 install --no-cache-dir meson

# Build FFmpeg from source to get the required version of libavcodec
RUN git clone https://git.ffmpeg.org/ffmpeg.git /ffmpeg && \
    cd /ffmpeg && \
    ./configure --enable-shared --disable-static --enable-gpl --enable-nonfree && \
    make -j$(nproc) && \
    make install && \
    ldconfig

# Create work directory
WORKDIR /app

# Copy repository
COPY . .

# Copy run.sh and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set entrypoint
ENTRYPOINT ["/app/run.sh"]