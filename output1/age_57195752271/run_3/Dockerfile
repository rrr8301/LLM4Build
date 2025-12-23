# Use Ubuntu as base image
FROM ubuntu:22.04

# Set timezone to avoid interactive prompts
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install dependencies including ICU and ca-certificates for SSL verification
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    ca-certificates \
    build-essential \
    libreadline-dev \
    zlib1g-dev \
    flex \
    bison \
    git \
    make \
    gcc \
    postgresql-client \
    libicu-dev \
    pkg-config \
    sudo \
    && rm -rf /var/lib/apt/lists/*

# Create a non-root user and group
RUN groupadd -r postgres && useradd -r -g postgres postgres

# Create work directory
WORKDIR /workspace

# Clone and build PostgreSQL 17 (with git config to skip SSL verification)
RUN git config --global http.sslVerify false && \
    git clone --depth 1 --branch REL_17_STABLE https://git.postgresql.org/git/postgresql.git /pg17source && \
    cd /pg17source && \
    ./configure --prefix=/pg17 CFLAGS="-std=gnu99 -ggdb -O0" --enable-cassert && \
    make install -j$(nproc) && \
    cd contrib && \
    cd fuzzystrmatch && \
    make PG_CONFIG=/pg17/bin/pg_config install -j$(nproc) && \
    cd ../pg_trgm && \
    make PG_CONFIG=/pg17/bin/pg_config install -j$(nproc)

# Clone pgvector
RUN git clone https://github.com/pgvector/pgvector.git /pgvector && \
    cd /pgvector && \
    make PG_CONFIG=/pg17/bin/pg_config install -j$(nproc)

# Copy AGE source code
COPY . /workspace

# Set ownership of pg17 directory
RUN chown -R postgres:postgres /pg17

# Copy and make run.sh executable
COPY run.sh /run.sh
RUN chmod +x /run.sh

# Set user and entrypoint
USER postgres
ENTRYPOINT ["/run.sh"]