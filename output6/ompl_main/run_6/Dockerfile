# Dockerfile
FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install dependencies
RUN apt-get update -y -qq && \
    apt-get install -y -qq --no-install-recommends \
    ca-certificates \
    cmake \
    make \
    g++ \
    libeigen3-dev \
    libflann-dev \
    libtriangle-dev \
    libyaml-cpp-dev \
    git \
    curl \
    zip \
    unzip \
    tar && \
    rm -rf /var/lib/apt/lists/*

# Install vcpkg for additional dependencies
WORKDIR /opt
RUN git clone https://github.com/microsoft/vcpkg.git && \
    ./vcpkg/bootstrap-vcpkg.sh

# Install the correct library using vcpkg
RUN ./vcpkg/vcpkg install vamp-sdk boost-test

# Create work directory
WORKDIR /app

# Copy repository contents
COPY . .

# Copy run.sh and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set entrypoint
ENTRYPOINT ["/app/run.sh"]