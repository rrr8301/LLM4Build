# Use Ubuntu as the base image
FROM ubuntu:latest

# Set the timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install necessary packages including git, vcpkg dependencies and lsb-release
# Added software-properties-common and gnupg for llvm.sh requirements
RUN apt-get update && \
    apt-get install -y wget make git curl zip unzip tar python3 ninja-build lsb-release \
    software-properties-common gnupg cmake build-essential && \
    rm -rf /var/lib/apt/lists/*

# Install LLVM/Clang 18
RUN wget https://apt.llvm.org/llvm.sh && \
    chmod +x llvm.sh && \
    ./llvm.sh 18 && \
    rm llvm.sh

# Set environment variables
ENV CC=/usr/bin/clang-18
ENV CXX=/usr/bin/clang++-18

# Install vcpkg and required libraries
RUN git clone https://github.com/microsoft/vcpkg.git /vcpkg && \
    /vcpkg/bootstrap-vcpkg.sh -disableMetrics && \
    ln -s /usr/bin/clang-18 /usr/bin/clang && \
    ln -s /usr/bin/clang++-18 /usr/bin/clang++ && \
    /vcpkg/vcpkg install abseil gtest benchmark --triplet x64-linux

# Set vcpkg environment variables
ENV VCPKG_ROOT=/vcpkg
ENV VCPKG_DEFAULT_TRIPLET=x64-linux
ENV PKG_CONFIG_PATH=/vcpkg/installed/x64-linux/lib/pkgconfig

# Create work directory
WORKDIR /app

# Copy the repository contents into the container
COPY . .

# Copy the run.sh script and make it executable
COPY run.sh /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh

# Set the entrypoint to run.sh
ENTRYPOINT ["/usr/local/bin/run.sh"]