FROM ubuntu:latest

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install OS-level dependencies
RUN apt-get update && \
    apt-get install -y wget build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev \
    libssl-dev libreadline-dev libffi-dev libsqlite3-dev libbz2-dev git python3-pip && \
    apt-get clean

# Download and install Python 3.13 prerelease
RUN wget https://www.python.org/ftp/python/3.13.0/Python-3.13.0a6.tgz && \
    tar -xzf Python-3.13.0a6.tgz && \
    cd Python-3.13.0a6 && \
    ./configure --enable-optimizations && \
    make -j $(nproc) && \
    make altinstall && \
    cd .. && \
    rm -rf Python-3.13.0a6 Python-3.13.0a6.tgz

# Create a working directory
WORKDIR /app

# Copy the repository contents
COPY . .

# Install Python dependencies
RUN python3.13 -m venv venv && \
    . venv/bin/activate && \
    pip install --upgrade pip && \
    pip install --upgrade --requirement requirements_test.txt

# Copy run.sh and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set the entrypoint
ENTRYPOINT ["/app/run.sh"]