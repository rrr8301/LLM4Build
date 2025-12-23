# Use Ubuntu 22.04 as the base image
FROM ubuntu:22.04

# Set the timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install OS-level dependencies
RUN apt-get update && apt-get install -y \
    git \
    python3 \
    python3-pip \
    python3-venv \
    build-essential \
    clang \
    gcc \
    g++ \
    cmake \
    ninja-build \
    && rm -rf /var/lib/apt/lists/*

# Set the working directory
WORKDIR /app

# Copy the repository into the container (including .git directory)
COPY . .

# Initialize and update submodules including googletest
RUN if [ -d .git ]; then \
        git submodule sync --recursive && \
        git submodule update --init --recursive && \
        cd FppTestProject && \
        git submodule sync --recursive && \
        git submodule update --init --recursive && \
        cd FppTest && \
        git submodule sync --recursive && \
        git submodule update --init --recursive; \
    else \
        echo "No .git directory found, skipping submodule update"; \
    fi

# Install Python dependencies
RUN pip3 install -r requirements.txt

# Make run.sh executable and set it as the entrypoint
RUN chmod +x /app/run.sh
ENTRYPOINT ["/app/run.sh"]