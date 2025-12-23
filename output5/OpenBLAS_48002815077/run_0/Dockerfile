FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install dependencies
RUN apt-get update && apt-get install -y \
    autoconf automake autotools-dev ninja-build make ccache \
    gcc-riscv64-linux-gnu gfortran-riscv64-linux-gnu libgomp1-riscv64-cross libglib2.0-dev \
    wget patch

# Create work directory
WORKDIR /workspace

# Copy repository
COPY . .

# Configure ccache
RUN mkdir -p ~/.ccache && \
    echo "max_size = 300M" > ~/.ccache/ccache.conf && \
    echo "compression = true" >> ~/.ccache/ccache.conf

# Copy run.sh and make it executable
COPY run.sh /workspace/run.sh
RUN chmod +x /workspace/run.sh

# Set entrypoint
ENTRYPOINT ["/workspace/run.sh"]