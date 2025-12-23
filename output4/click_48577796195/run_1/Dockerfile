FROM ubuntu:latest

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install OS-level dependencies
RUN apt-get update && apt-get install -y \
    curl \
    git \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Install PyPy 3.11
RUN curl -sSL https://downloads.python.org/pypy/pypy3.11-v7.3.12-linux64.tar.bz2 | tar -xj -C /opt/ && \
    ln -s /opt/pypy3.11-v7.3.12-linux64/bin/pypy3 /usr/local/bin/python

# Install pip and tox
RUN curl -sSL https://bootstrap.pypa.io/get-pip.py | python && \
    pip install tox

# Install uv
RUN pip install uv

# Create work directory
WORKDIR /app

# Copy repository contents
COPY . .

# Copy run.sh and make it executable
COPY run.sh /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh

# Set entrypoint
ENTRYPOINT ["/usr/local/bin/run.sh"]