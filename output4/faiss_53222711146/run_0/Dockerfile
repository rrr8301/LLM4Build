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
    lsb-release \
    software-properties-common

# Install Miniconda
RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O /tmp/miniconda.sh && \
    bash /tmp/miniconda.sh -b -p /opt/conda && \
    rm /tmp/miniconda.sh
ENV PATH="/opt/conda/bin:$PATH"

# Create a working directory
WORKDIR /app

# Copy the repository into the container
COPY . .

# Install conda dependencies
RUN conda install -y -c conda-forge \
    python=3.11 \
    cmake=3.30.4 \
    make=4.2 \
    swig=4.0 \
    "numpy>=2.0,<3.0" \
    scipy=1.16 \
    pytest=7.4 \
    gflags=2.2 \
    gxx_linux-64=14.2 \
    sysroot_linux-64=2.17 \
    mkl=2024.2.2 \
    mkl-devel=2024.2.2

# Copy and set permissions for the run script
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set the entrypoint
ENTRYPOINT ["/app/run.sh"]