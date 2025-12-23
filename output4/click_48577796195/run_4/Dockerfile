FROM ubuntu:latest

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install necessary packages
RUN apt-get update && apt-get install -y \
    curl \
    build-essential \
    git \
    bzip2 \
    && rm -rf /var/lib/apt/lists/*

# Install PyPy 3.11
RUN curl -sSL https://downloads.python.org/pypy/pypy3.9-v7.3.9-linux64.tar.bz2 -o pypy.tar.bz2 && \
    tar -xjf pypy.tar.bz2 -C /opt/ && \
    ln -s /opt/pypy3.9-v7.3.9-linux64/bin/pypy3 /usr/local/bin/python && \
    rm pypy.tar.bz2

# Add PyPy bin directory to PATH
ENV PATH="/opt/pypy3.9-v7.3.9-linux64/bin:${PATH}"

# Install pip and tox
RUN curl -sSL https://bootstrap.pypa.io/get-pip.py | python && \
    pip install tox

# Create work directory
WORKDIR /app

# Copy repository contents
COPY . .

# Ensure requirements.txt is present
RUN if [ ! -f requirements.txt ]; then echo "uv" > requirements.txt; fi

# Install uv
RUN pip install -r requirements.txt

# Copy run.sh and make it executable
COPY run.sh /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh

# Set entrypoint
ENTRYPOINT ["/usr/local/bin/run.sh"]