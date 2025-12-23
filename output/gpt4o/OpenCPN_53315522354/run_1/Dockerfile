FROM ubuntu:latest

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install dependencies
RUN apt-get update && apt-get install -y \
    cmake \
    make \
    g++ \
    git \
    pkg-config \
    libgtk-3-dev \
    libgl1-mesa-dev \
    libglu1-mesa-dev \
    libwxgtk3.2-dev \
    && rm -rf /var/lib/apt/lists/*

# Create work directory
WORKDIR /app

# Copy repository contents
COPY . .

# Make scripts executable
RUN chmod +x /app/ci/github-pre-build.sh && \
    chmod +x /app/run.sh

# Set entrypoint
ENTRYPOINT ["/app/run.sh"]