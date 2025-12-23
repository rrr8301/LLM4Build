# Use Ubuntu as the base image
FROM ubuntu:latest

# Set the timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install necessary packages including git, vcpkg dependencies and lsb-release
RUN apt-get update && \
    apt-get install -y wget make git curl zip unzip tar python3 ninja-build lsb-release && \
    rm -rf /var/lib/apt/lists/*

# Install LLVM/Clang 18
RUN wget https://apt.llvm.org/llvm.sh && \
    chmod +x llvm.sh && \
    ./llvm.sh 18 && \
    rm llvm.sh

# Install vcpkg and required libraries
RUN git clone https://github.com/microsoft/vcpkg.git /vcpkg && \
    /vcpkg/bootstrap-vcpkg.sh -disableMetrics && \
    /vcpkg/vcpkg install abseil gtest benchmark --triplet x64-linux

# Set environment variables
ENV CC=/usr/bin/clang-18
ENV CXX=/usr/bin/clang++-18
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