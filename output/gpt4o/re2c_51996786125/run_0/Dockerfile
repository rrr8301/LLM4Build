FROM ubuntu:latest

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install OS-level dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    gcc-multilib g++-multilib valgrind cmake make git python3 python3-pip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Set up Python environment
RUN python3 -m pip install --upgrade pip

# Create work directory
WORKDIR /workspace

# Copy repository contents
COPY . .

# Install Python dependencies
RUN python3 -m pip install docutils pygments

# Copy run.sh and make it executable
COPY run.sh /workspace/run.sh
RUN chmod +x /workspace/run.sh

# Set entrypoint
ENTRYPOINT ["/workspace/run.sh"]