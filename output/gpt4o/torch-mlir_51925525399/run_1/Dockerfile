FROM ubuntu:20.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    software-properties-common \
    && add-apt-repository ppa:deadsnakes/ppa \
    && apt-get update && apt-get install -y \
    python3.11 \
    python3.11-venv \
    python3-pip \
    ccache \
    ninja-build \
    git \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Set up Python environment
RUN python3.11 -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

# Create work directory
WORKDIR /app

# Copy repository
COPY . .

# Install Python dependencies
RUN pip install --upgrade pip
RUN ./build_tools/ci/install_python_deps.sh stable

# Copy run.sh and make it executable
COPY run.sh /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh

# Set entrypoint
ENTRYPOINT ["/usr/local/bin/run.sh"]