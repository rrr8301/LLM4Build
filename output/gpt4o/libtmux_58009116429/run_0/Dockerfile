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
    python3.14 \
    python3-pip

# Create work directory
WORKDIR /app

# Copy repository files
COPY . .

# Install Python dependencies
RUN pip install -r docs/requirements.txt

# Copy run.sh and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set entrypoint
ENTRYPOINT ["/app/run.sh"]