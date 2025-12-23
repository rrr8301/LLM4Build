# Dockerfile
FROM ubuntu:24.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install dependencies including CA certificates
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    ca-certificates \
    libltdl-dev libx11-dev libxft-dev libxext-dev libwayland-dev libxkbcommon-dev libegl1-mesa-dev libibus-1.0-dev \
    cmake ninja-build git build-essential gcc g++ && \
    rm -rf /var/lib/apt/lists/* && \
    update-ca-certificates

# Create work directory
WORKDIR /app

# Initialize vcpkg first
RUN git config --global http.sslVerify true && \
    git clone https://github.com/Microsoft/vcpkg.git && \
    cd vcpkg && \
    git checkout $(git describe --tags $(git rev-list --tags --max-count=1)) && \
    ./bootstrap-vcpkg.sh && \
    cd ..

# Copy repository contents
COPY . .

# Initialize other submodules
RUN git submodule update --init --recursive || echo "Warning: Git submodule update failed, continuing anyway"

# Copy run.sh and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set entrypoint
ENTRYPOINT ["/app/run.sh"]