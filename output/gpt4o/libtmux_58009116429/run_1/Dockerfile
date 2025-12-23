FROM ubuntu:latest

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install OS-level dependencies
RUN apt-get update && apt-get install -y \
    libevent-dev \
    libncurses5-dev \
    libtinfo-dev \
    libutempter-dev \
    bison \
    libevent-2.1-7 \
    git \
    make \
    autogen \
    python3-pip \
    wget \
    build-essential \
    zlib1g-dev \
    libncurses5-dev \
    libgdbm-dev \
    libnss3-dev \
    libssl-dev \
    libreadline-dev \
    libffi-dev \
    libsqlite3-dev \
    libbz2-dev

# Install Python 3.14 from source
RUN wget https://www.python.org/ftp/python/3.14.0/Python-3.14.0.tgz && \
    tar -xf Python-3.14.0.tgz && \
    cd Python-3.14.0 && \
    ./configure --enable-optimizations && \
    make -j $(nproc) && \
    make altinstall && \
    cd .. && \
    rm -rf Python-3.14.0 Python-3.14.0.tgz

# Create work directory
WORKDIR /app

# Copy repository files
COPY . .

# Install Python dependencies
RUN python3.14 -m pip install -r docs/requirements.txt

# Copy run.sh and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set entrypoint
ENTRYPOINT ["/app/run.sh"]