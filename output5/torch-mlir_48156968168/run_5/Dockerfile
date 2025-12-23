FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    software-properties-common \
    python3.11 \
    python3-pip \
    python3.11-dev \
    python3.11-venv \
    build-essential \
    ccache \
    git && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Create work directory
WORKDIR /app

# Copy repository contents
COPY . .

# Ensure the requirements file is in place
RUN mkdir -p /app/externals/llvm-project/mlir/python && \
    touch /app/externals/llvm-project/mlir/python/requirements.txt

# Clone the necessary llvm-project repository
RUN rm -rf /app/externals/llvm-project && \
    git clone --depth 1 https://github.com/llvm/llvm-project.git /app/externals/llvm-project

# Make run.sh executable and set as entrypoint
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh
ENTRYPOINT ["/app/run.sh"]