# Dockerfile
FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -fs /usr/share/zoneinfo/$TZ /etc/localtime && \
    apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y tzdata

# Install build prerequisites
RUN apt-get update && \
    apt-get install -qy bzip2 curl g++ haskell-stack libtinfo-dev make procps zlib1g-dev gdb wget

# Install a compatible version of GHC
RUN stack setup 8.10.7

# Install Acton
RUN install -m 0755 -d /etc/apt/keyrings && \
    wget -q -O /etc/apt/keyrings/acton.asc https://apt.acton-lang.io/acton.gpg && \
    chmod a+r /etc/apt/keyrings/acton.asc && \
    echo "deb [signed-by=/etc/apt/keyrings/acton.asc arch=amd64] http://apt.acton-lang.io/ stable main" | tee -a /etc/apt/sources.list.d/acton.list && \
    apt-get update && \
    apt-get install -qy acton

# Create work directory
WORKDIR /app

# Copy repository code
COPY . .

# Copy run.sh and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set entrypoint
ENTRYPOINT ["/app/run.sh"]