FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install OS-level dependencies
RUN apt-get update && apt-get install -y \
    wget \
    software-properties-common \
    gnupg \
    sudo

# Install Miniconda
RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O /miniconda.sh && \
    bash /miniconda.sh -b -p /opt/conda && \
    rm /miniconda.sh
ENV PATH="/opt/conda/bin:$PATH"

# Create and activate conda environment
RUN conda create -n faiss-env python=3.11 && \
    echo "source activate faiss-env" > ~/.bashrc
ENV PATH /opt/conda/envs/faiss-env/bin:$PATH

# Install conda dependencies
RUN conda install -y -c conda-forge \
    cmake=3.30.4 \
    make=4.2 \
    swig=4.0 \
    "numpy<2" \
    scipy=1.14 \
    pytest=7.4 \
    gflags=2.2 \
    mkl=2022.2.1 \
    mkl-devel=2022.2.1

# Create work directory
WORKDIR /app

# Copy repository
COPY . .

# Copy run.sh and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set entrypoint
ENTRYPOINT ["/app/run.sh"]