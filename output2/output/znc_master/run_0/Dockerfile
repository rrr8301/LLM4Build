FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install dependencies
RUN apt-get update && apt-get install -y \
    make \
    pkg-config \
    gcc \
    clang \
    cmake \
    libssl-dev \
    libicu-dev \
    gettext \
    libargon2-dev \
    libperl-dev \
    python3-dev \
    swig \
    libsasl2-dev \
    libboost-locale-dev \
    && rm -rf /var/lib/apt/lists/*

# Create work directory
WORKDIR /app

# Copy repository
COPY . .

# Copy and set permissions for run.sh
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set entrypoint
ENTRYPOINT ["/app/run.sh"]