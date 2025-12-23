# Dockerfile
FROM ubuntu:latest

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install dependencies including C++ compiler, git, and Java
RUN apt-get update && apt-get install -y \
    cmake \
    cmake-curses-gui \
    g++ \
    git \
    pkg-config \
    libprotobuf-dev \
    libgtest-dev \
    libre2-dev \
    libicu-dev \
    libboost-dev \
    libboost-thread-dev \
    libboost-system-dev \
    protobuf-compiler \
    make \
    default-jre \
    default-jdk \
    && rm -rf /var/lib/apt/lists/*

# Install Abseil with PIC enabled
RUN git clone https://github.com/abseil/abseil-cpp.git && \
    cd abseil-cpp && \
    cmake -DCMAKE_POSITION_INDEPENDENT_CODE=ON . && \
    make && \
    make install

# Create work directory
WORKDIR /app

# Copy repository contents
COPY . .

# Build the C++ project
RUN mkdir -p cpp/build && \
    cd cpp/build && \
    cmake .. && \
    make

# Copy run.sh and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set entrypoint
ENTRYPOINT ["/app/run.sh"]