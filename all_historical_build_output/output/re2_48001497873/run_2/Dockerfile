# Use the base image
FROM ubuntu:22.04

# Set the timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install required packages
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    wget \
    make \
    ca-certificates \
    apt-utils \
    lsb-release \
    && rm -rf /var/lib/apt/lists/*

# Install Clang 18
RUN wget https://apt.llvm.org/llvm.sh && \
    chmod +x ./llvm.sh && \
    ./llvm.sh 18 && \
    rm llvm.sh

# Install vcpkg
RUN git clone https://github.com/microsoft/vcpkg.git /opt/vcpkg && \
    /opt/vcpkg/bootstrap-vcpkg.sh

# Set environment variables
ENV CC=clang-18
ENV CXX=clang++-18
ENV PKG_CONFIG_PATH=/usr/local/share/vcpkg/installed/x64-linux/lib/pkgconfig

# Create work directory
WORKDIR /app

# Copy the repository
COPY . .

# Install dependencies using vcpkg
RUN /opt/vcpkg/vcpkg update && \
    /opt/vcpkg/vcpkg install abseil gtest benchmark

# Copy run.sh and make it executable
COPY run.sh /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh

# Set the entrypoint
ENTRYPOINT ["/usr/local/bin/run.sh"]