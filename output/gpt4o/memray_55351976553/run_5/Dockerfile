FROM alpine:latest

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles

# Install dependencies
RUN apk add --no-cache \
    build-base libunwind-dev lz4-dev musl-dev python3-dev python3-dbg gdb lldb git bash perl perl-datetime \
    perl-app-cpanminus \
    argp-standalone bison bsd-compat-headers bzip2-dev curl curl-dev flex-dev libtool linux-headers musl-fts-dev \
    musl-libintl musl-obstack-dev xz-dev zlib-dev zstd-dev autoconf automake && \
    cpanm Date::Parse && \
    cpanm Capture::Tiny

# Install elfutils
RUN cd / && \
    curl -L https://mirrors.kernel.org/sourceware/elfutils/0.191/elfutils-0.191.tar.bz2 -o elfutils.tar.bz2 && \
    tar -xf elfutils.tar.bz2 && \
    cd elfutils-0.191 && \
    CFLAGS='-Wno-error -DFNM_EXTMATCH=0 -g -O3' CXXFLAGS='-Wno-error -DFNM_EXTMATCH=0 -g -O3' ./configure --enable-libdebuginfod --disable-debuginfod --disable-nls --with-zstd && \
    make install

# Clone and build lcov
RUN git clone https://github.com/linux-test-project/lcov.git && \
    cd lcov && \
    make install

# Create work directory
WORKDIR /app

# Copy repository
COPY . .

# Fix permissions for libbacktrace configure script
RUN if [ -f "src/vendor/libbacktrace/configure.ac" ]; then \
        cd src/vendor/libbacktrace && \
        autoconf && \
        chmod +x configure; \
    fi

# Install Python dependencies directly
RUN python3 -m venv /venv && \
    /venv/bin/python -m pip install --upgrade pip && \
    /venv/bin/python -m pip install build && \
    /venv/bin/python -m pip install -e .[test,dev] && \
    /venv/bin/python -m build && \
    /venv/bin/python -m pip install dist/*.whl[test,dev]