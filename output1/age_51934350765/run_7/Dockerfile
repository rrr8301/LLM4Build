# Dockerfile
FROM ubuntu:latest

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    libreadline-dev \
    zlib1g-dev \
    flex \
    bison \
    git \
    libicu-dev \
    pkg-config \
    curl \
    postgresql \
    postgresql-contrib

# Create a non-root user
RUN useradd -ms /bin/bash pguser

# Create work directory
WORKDIR /app

# Copy repository contents
COPY . .

# Install PostgreSQL 17 and extensions
RUN set -e; \
    for i in 1 2 3 4 5; do \
        git clone --depth 1 --branch REL_17_STABLE https://git.postgresql.org/git/postgresql.git /pg17source && break || sleep 10; \
    done && \
    cd /pg17source && \
    ./configure --prefix=/usr/local/pg17 CFLAGS="-std=gnu99 -ggdb -O0" --enable-cassert --with-icu && \
    make install -j$(nproc) && \
    cd contrib/fuzzystrmatch && \
    make PG_CONFIG=/usr/local/pg17/bin/pg_config install -j$(nproc) && \
    cd ../pg_trgm && \
    make PG_CONFIG=/usr/local/pg17/bin/pg_config install -j$(nproc)

# Copy and set run.sh as entrypoint
COPY run.sh /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh

# Change ownership of the PostgreSQL data directory
RUN mkdir -p /usr/local/pg17/data && chown -R pguser:pguser /usr/local/pg17

# Switch to the non-root user
USER pguser

ENTRYPOINT ["/usr/local/bin/run.sh"]