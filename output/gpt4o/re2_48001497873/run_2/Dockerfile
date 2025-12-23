# Use Ubuntu as the base image
FROM ubuntu:latest

# Set the timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install necessary packages including git and vcpkg dependencies
RUN apt-get update && \
    apt-get install -y wget make git clang-18 clang++-18 curl zip unzip tar && \
    rm -rf /var/lib/apt/lists/*

# Install vcpkg and required libraries
RUN git clone https://github.com/microsoft/vcpkg.git /vcpkg && \
    /vcpkg/bootstrap-vcpkg.sh && \
    /vcpkg/vcpkg install abseil gtest benchmark

# Set environment variables
ENV CC=clang-18
ENV CXX=clang++-18
ENV PKG_CONFIG_PATH=/usr/local/share/vcpkg/installed/x64-linux/lib/pkgconfig

# Create work directory
WORKDIR /app

# Copy the repository contents into the container
COPY . .

# Copy the run.sh script and make it executable
COPY run.sh /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh

# Set the entrypoint to run.sh
ENTRYPOINT ["/usr/local/bin/run.sh"]