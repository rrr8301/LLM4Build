# Use Ubuntu 24.04 as the base image
FROM ubuntu:24.04

# Set the timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install required packages with additional dependencies for autoreconf
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    automake autoconf libtool crossbuild-essential-amd64 \
    make gcc git pkg-config libtool-bin && \
    rm -rf /var/lib/apt/lists/*

# Create a working directory
WORKDIR /app

# Copy the repository into the container including .git directory
COPY . .

# Initialize and update submodules
RUN if [ -d .git ]; then \
        git submodule update --init --recursive; \
    fi

# Fix permissions for scripts
RUN chmod +x scripts/*

# Handle oniguruma build differently - use the existing build system if possible
RUN if [ -d "vendor/oniguruma" ]; then \
        cd vendor/oniguruma && \
        if [ -f "configure" ]; then \
            ./configure --enable-static --disable-shared && \
            make -j"$(nproc)"; \
        elif [ -f "Makefile" ]; then \
            make -j"$(nproc)"; \
        else \
            autoreconf -vfi && \
            ./configure --enable-static --disable-shared && \
            make -j"$(nproc)"; \
        fi && \
        cd ../..; \
    fi