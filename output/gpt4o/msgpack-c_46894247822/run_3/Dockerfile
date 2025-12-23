# Dockerfile
FROM ubuntu:24.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install dependencies with specific versions to avoid conflicts
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    g++-10 \
    cmake \
    make \
    valgrind \
    g++-10-multilib \
    clang-14 \
    clang-tools-14 \
    llvm-14-dev \
    libclang-14-dev \
    && rm -rf /var/lib/apt/lists/*

# Create symbolic links for clang and gcc
RUN update-alternatives --install /usr/bin/clang clang /usr/bin/clang-14 100 && \
    update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-14 100 && \
    update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-10 100 && \
    update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-10 100

# Create work directory
WORKDIR /app

# Copy repository contents and set execute permissions
COPY . .
RUN chmod +x ci/build_cmake.sh

# Make run.sh executable and set as entrypoint
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh
ENTRYPOINT ["/app/run.sh"]