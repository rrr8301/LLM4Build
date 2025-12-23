FROM ubuntu:latest

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install dependencies
RUN apt-get update && apt-get install -y \
    python3.12 \
    python3.12-venv \
    python3-pip \
    wget \
    gnupg \
    clang \
    llvm \
    lld \
    git \
    unzip \  # Added unzip package
    && apt-get clean

# Install Bazel
RUN wget https://github.com/bazelbuild/bazel/releases/download/6.4.0/bazel-6.4.0-installer-linux-x86_64.sh && \
    chmod +x bazel-6.4.0-installer-linux-x86_64.sh && \
    ./bazel-6.4.0-installer-linux-x86_64.sh && \
    rm bazel-6.4.0-installer-linux-x86_64.sh

# Create work directory
WORKDIR /app

# Copy repository
COPY . .

# Install Python dependencies if any
# RUN pip install -r requirements.txt

# Copy run.sh and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set entrypoint
ENTRYPOINT ["/app/run.sh"]