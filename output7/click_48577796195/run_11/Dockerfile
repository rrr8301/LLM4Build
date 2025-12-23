# Dockerfile
FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install necessary packages
RUN apt-get update && apt-get install -y \
    curl \
    wget \
    git \
    make \
    gcc \
    bzip2 \
    && rm -rf /var/lib/apt/lists/*

# Install PyPy 3.11
RUN wget -qO /tmp/pypy.tar.bz2 https://downloads.python.org/pypy/pypy3.9-v7.3.12-linux64.tar.bz2 || { echo "Failed to download PyPy"; exit 1; } && \
    tar -xjf /tmp/pypy.tar.bz2 -C /opt/ && \
    ln -s /opt/pypy3.9-v7.3.12-linux64/bin/pypy3 /usr/local/bin/python && \
    rm /tmp/pypy.tar.bz2

# Add PyPy binary directory to PATH
ENV PATH="/opt/pypy3.9-v7.3.12-linux64/bin:$PATH"

# Install pip and tox
RUN curl -sS https://bootstrap.pypa.io/get-pip.py | python && \
    pip install tox

# Create work directory
WORKDIR /app

# Copy repository contents
COPY . .

# Copy run.sh and make it executable
COPY run.sh /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh

# Set entrypoint
ENTRYPOINT ["/usr/local/bin/run.sh"]