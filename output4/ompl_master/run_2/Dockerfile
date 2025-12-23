FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install dependencies
RUN apt-get update -y -qq && \
    apt-get install -y -qq \
    libboost-program-options-dev \
    libboost-serialization-dev \
    libboost-test-dev \
    libeigen3-dev \
    libflann-dev \
    libtriangle-dev \
    libyaml-cpp-dev \
    cmake \
    make \
    g++ \
    git \
    wget \
    python3-pip

# Install OMPL from source
RUN git clone https://github.com/ompl/ompl.git /tmp/ompl && \
    cd /tmp/ompl && \
    mkdir -p build/Release && \
    cd build/Release && \
    cmake ../.. -DCMAKE_INSTALL_PREFIX=/usr/local && \
    make -j$(nproc) && \
    make install && \
    rm -rf /tmp/ompl

# Upgrade pip and install Python dependencies
RUN pip install --upgrade pip

# Create work directory
WORKDIR /app

# Copy repository contents
COPY . .

# Copy run.sh and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set entrypoint
ENTRYPOINT ["/app/run.sh"]