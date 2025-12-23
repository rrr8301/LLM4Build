FROM ubuntu:22.04

# Install system dependencies
RUN apt-get update && apt-get install -y \
    wget \
    bzip2 \
    && rm -rf /var/lib/apt/lists/*

# Install Miniconda
RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O /tmp/miniconda.sh && \
    bash /tmp/miniconda.sh -b -p /opt/conda && \
    rm /tmp/miniconda.sh

ENV PATH="/opt/conda/bin:$PATH"

# Update conda and create the environment
RUN conda update -n base -c defaults conda -y && \
    conda create -n test python=3.10 -y && \
    conda clean -a -y

# Set the working directory
WORKDIR /app

# Copy the repository into the container
COPY . .

# Install Python dependencies
RUN /opt/conda/bin/conda run -n test python -m pip install --upgrade pip && \
    /opt/conda/bin/conda run -n test python -m pip install torch torchvision torchaudio && \
    /opt/conda/bin/conda run -n test python -m pip install -e ".[dev]"

# Copy the run.sh script and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set the entrypoint
ENTRYPOINT ["/app/run.sh"]