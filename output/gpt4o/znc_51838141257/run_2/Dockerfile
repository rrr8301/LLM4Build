FROM ubuntu:24.04

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
    openssl \
    libssl-dev \
    perl \
    swig \
    python3 \
    python3-pip \
    libpython3-dev \
    libicu-dev \
    gettext \
    libargon2-dev \
    git \
    curl \
    sudo \
    lcov \
    cpanminus \
    libmodule-install-perl

# Install Perl modules for coverage
RUN cpanm Devel::Cover

# Create work directory
WORKDIR /app

# Copy repository
COPY . .

# Copy run.sh and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set entrypoint
ENTRYPOINT ["/app/run.sh"]