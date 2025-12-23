# Dockerfile
FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install dependencies
RUN apt-get update && apt-get install -y \
    curl \
    gnupg \
    ca-certificates \
    bzip2 \
    && rm -rf /var/lib/apt/lists/*

# Install PyPy 3.11
RUN curl -sSL https://downloads.python.org/pypy/pypy3.11-v7.3.11-linux64.tar.bz2 | tar -xj -C /opt/ && \
    ln -s /opt/pypy3.11-v7.3.11-linux64/bin/pypy3 /usr/local/bin/python

# Install pip and tox
RUN curl -sSL https://bootstrap.pypa.io/get-pip.py | python && \
    pip install tox

# Create work directory
WORKDIR /app

# Copy repository
COPY . .

# Copy run.sh and make it executable
COPY run.sh /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh

# Set entrypoint
ENTRYPOINT ["/usr/local/bin/run.sh"]