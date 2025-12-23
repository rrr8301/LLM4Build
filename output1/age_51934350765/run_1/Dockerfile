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
    libicu-dev  # Added ICU development package

# Create work directory
WORKDIR /app

# Copy repository contents
COPY . .

# Install PostgreSQL 17 and extensions
RUN git clone --depth 1 --branch REL_17_STABLE https://git.postgresql.org/git/postgresql.git /pg17source && \
    cd /pg17source && \
    ./configure --prefix=/usr/local/pg17 CFLAGS="-std=gnu99 -ggdb -O0" --enable-cassert && \
    make install -j$(nproc) && \
    cd contrib/fuzzystrmatch && \
    make PG_CONFIG=/usr/local/pg17/bin/pg_config install -j$(nproc) && \
    cd ../pg_trgm && \
    make PG_CONFIG=/usr/local/pg17/bin/pg_config install -j$(nproc)

# Copy and set run.sh as entrypoint
COPY run.sh /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh
ENTRYPOINT ["/usr/local/bin/run.sh"]