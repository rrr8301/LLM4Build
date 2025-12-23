FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -fs /usr/share/zoneinfo/$TZ /etc/localtime && \
    apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y tzdata

# Install dependencies
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y cmake make g++ git devscripts equivs

# Create work directory
WORKDIR /app

# Copy repository
COPY . .

# Run pre-build script
RUN sed -i 's/sudo //g' ./ci/github-pre-build.sh && \
    DEBIAN_FRONTEND=noninteractive ./ci/github-pre-build.sh || true

# Configure CMake
RUN cmake -B build -DCMAKE_BUILD_TYPE=Release

# Build the project
RUN cmake --build build --config Release

# Copy run.sh, make it executable, and set as entrypoint
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh
ENTRYPOINT ["/app/run.sh"]