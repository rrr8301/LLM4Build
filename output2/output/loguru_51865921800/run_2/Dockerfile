# Dockerfile
FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install PyPy and pip
RUN apt-get update && \
    apt-get install -y software-properties-common wget python3-venv && \
    add-apt-repository ppa:pypy/ppa && \
    apt-get update && \
    apt-get install -y pypy3 pypy3-dev pypy3-venv && \
    pypy3 -m ensurepip && \
    pypy3 -m pip install --upgrade pip

# Install tox
RUN pypy3 -m pip install tox

# Create work directory
WORKDIR /app

# Copy repository
COPY . .

# Copy run.sh, make it executable, and set as entrypoint
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh
ENTRYPOINT ["/app/run.sh"]