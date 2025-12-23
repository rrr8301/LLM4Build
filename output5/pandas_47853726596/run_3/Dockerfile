FROM ubuntu:24.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install necessary packages
RUN apt-get update && apt-get install -y \
    wget \
    bzip2 \
    libegl1 \
    libopengl0 \
    locales \
    && locale-gen en_US.UTF-8

# Set the locale
ENV LANG=C.UTF-8
ENV LC_ALL=C.UTF-8

# Install Miniconda
RUN wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O /tmp/miniconda.sh && \
    bash /tmp/miniconda.sh -b -p /opt/conda && \
    rm /tmp/miniconda.sh

# Add conda to PATH
ENV PATH="/opt/conda/bin:$PATH"

# Accept Conda Terms of Service
RUN conda config --set channel_priority strict && \
    conda tos accept --override-channels --channel https://repo.anaconda.com/pkgs/main && \
    conda tos accept --override-channels --channel https://repo.anaconda.com/pkgs/r

# Create work directory
WORKDIR /app

# Copy the repository
COPY . .

# Install Conda environment
RUN conda env create -f ci/deps/actions-311.yaml

# Ensure the environment name is known
# Replace 'myenv' with the actual environment name specified in actions-311.yaml
ENV CONDA_ENV_NAME=myenv

# Copy run.sh and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set entrypoint
ENTRYPOINT ["/app/run.sh"]