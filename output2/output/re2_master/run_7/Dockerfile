# Use the base image
FROM ubuntu:22.04

# Set the timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install necessary packages
RUN apt-get update && apt-get install -y \
    wget \
    make \
    curl \
    lsb-release \
    software-properties-common \
    gnupg \
    git \
    zip \
    unzip \
    tar && \
    rm -rf /var/lib/apt/lists/*

# Install Clang 20
RUN wget https://apt.llvm.org/llvm.sh && \
    chmod +x ./llvm.sh && \
    ./llvm.sh 20 && \
    rm llvm.sh

# Install vcpkg
RUN git clone https://github.com/microsoft/vcpkg.git && \
    cd vcpkg && \
    ./bootstrap-vcpkg.sh && \
    ./vcpkg install abseil gtest benchmark && \
    ./vcpkg integrate install

# Set environment variables
ENV CC=clang-20
ENV CXX=clang++-20
ENV PKG_CONFIG_PATH=/usr/local/share/vcpkg/installed/x64-linux/lib/pkgconfig
ENV PATH="/vcpkg:${PATH}"

# Create work directory
WORKDIR /app

# Copy the repository
COPY . .

# Copy run.sh, make it executable, and set as entrypoint
COPY run.sh /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh
ENTRYPOINT ["/usr/local/bin/run.sh"]