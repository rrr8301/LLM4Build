FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install OS-level dependencies
RUN apt-get update && apt-get install -y \
    wget \
    sudo \
    git \
    gnupg \
    kmod

# Install Miniconda
RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O /miniconda.sh && \
    bash /miniconda.sh -b -p /opt/conda && \
    rm /miniconda.sh
ENV PATH="/opt/conda/bin:$PATH"

# Create and activate conda environment
RUN conda create -n faiss-env python=3.11 cmake=3.30.4 make=4.2 swig=4.0 numpy>=1.21,<2.0 scipy=1.16 pytest=7.4 gflags=2.2 mkl=2024.2.2 mkl-devel=2024.2.2 gxx_linux-64=14.2 sysroot_linux-64=2.17 -c conda-forge

# Create work directory
WORKDIR /workspace

# Copy the repository
COPY . .

# Copy run.sh and make it executable
COPY run.sh /workspace/run.sh
RUN chmod +x /workspace/run.sh

# Set entrypoint
ENTRYPOINT ["/workspace/run.sh"]