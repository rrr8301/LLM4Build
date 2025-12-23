# Dockerfile
FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install necessary packages and PyPy
RUN apt-get update && \
    apt-get install -y software-properties-common wget python3-venv python3-pip dos2unix && \
    add-apt-repository ppa:pypy/ppa && \
    apt-get update && \
    apt-get install -y pypy3 pypy3-dev pypy3-venv

# Install pip for PyPy
RUN pypy3 -m venv /app/venv && \
    /app/venv/bin/pypy3 -m ensurepip && \
    /app/venv/bin/pip install --upgrade pip

# Install tox
RUN /app/venv/bin/pip install tox

# Create work directory
WORKDIR /app

# Copy repository
COPY . .

# Copy run.sh, make it executable, convert line endings, and set as entrypoint
COPY run.sh /app/run.sh
RUN dos2unix /app/run.sh && chmod +x /app/run.sh
ENTRYPOINT ["/app/run.sh"]