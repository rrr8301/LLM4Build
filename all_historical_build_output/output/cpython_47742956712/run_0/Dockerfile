FROM ubuntu:24.04

# Install OS-level dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    libssl-dev \
    zlib1g-dev \
    libncurses5-dev \
    libncursesw5-dev \
    libreadline-dev \
    libsqlite3-dev \
    libgdbm-dev \
    libdb5.3-dev \
    libbz2-dev \
    libexpat1-dev \
    liblzma-dev \
    tk-dev \
    libffi-dev \
    wget \
    make \
    gcc \
    g++

# Set the working directory
WORKDIR /usr/src/app

# Copy the repository contents into the container
COPY . .

# Install Python 3.15.0 alpha 0
RUN ./configure && make && make install

# Copy the run.sh script and make it executable
COPY run.sh /usr/src/app/run.sh
RUN chmod +x /usr/src/app/run.sh

# Set the entrypoint to run.sh
ENTRYPOINT ["/usr/src/app/run.sh"]