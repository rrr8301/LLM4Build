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

# Handle oniguruma build with minimal configuration if Makefile.am is missing
RUN if [ -d "vendor/oniguruma" ]; then \
        cd vendor/oniguruma && \
        if [ ! -f "Makefile.am" ]; then \
            echo "Creating minimal Makefile.am for oniguruma"; \
            cat > Makefile.am << 'EOF' && \
lib_LIBRARIES = libonig.a && \
libonig_a_SOURCES = regcomp.c regenc.c regerror.c regexec.c regparse.c regsyntax.c regtrav.c regversion.c st.c onig_init.c && \
include_HEADERS = oniguruma.h onig-config.h && \
AM_CFLAGS = -Wall -O2 -pthread -fstack-protector-all \
EOF
            autoreconf -vfi && \
            ./configure --enable-static --disable-shared; \
        fi && \
        make -j"$(nproc)" && \
        cd ../..; \
    fi

# Verify configure.ac exists before running autoreconf
RUN if [ ! -f "configure.ac" ] && [ ! -f "src/configure.ac" ] && [ ! -f "jq/configure.ac" ]; then \
        echo "Error: configure.ac not found in root directory or expected subdirectories"; \
        exit 1; \
    fi

# Copy the run.sh script and make it executable
COPY run.sh /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh

# Set the entrypoint to run.sh
ENTRYPOINT ["/usr/local/bin/run.sh"]