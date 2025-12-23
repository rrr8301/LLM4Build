FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install dependencies
RUN apt-get update -y -qq && \
    apt-get install -y -qq \
    cmake \
    make \
    g++ \
    libboost-program-options-dev \
    libboost-serialization-dev \
    libboost-test-dev \
    libeigen3-dev \
    libflann-dev \
    libtriangle-dev \
    libyaml-cpp-dev \
    wget \
    python3 \
    python3-pip

# Install OMPL from source to ensure correct version and configuration
RUN apt-get install -y -qq git
RUN git clone https://github.com/ompl/ompl.git /tmp/ompl && \
    cd /tmp/ompl && \
    mkdir -p build && cd build && \
    cmake .. -DCMAKE_INSTALL_PREFIX=/usr/local && \
    make -j$(nproc) && \
    make install && \
    rm -rf /tmp/ompl

# Create work directory
WORKDIR /app

# Copy repository
COPY . .

# Copy run.sh and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set entrypoint
ENTRYPOINT ["/app/run.sh"]