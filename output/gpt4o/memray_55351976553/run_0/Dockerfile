FROM alpine:latest

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles

# Install dependencies
RUN apk add --no-cache \
    build-base libunwind-dev lz4-dev musl-dev python3-dev python3-dbg gdb lldb git bash perl perl-datetime \
    argp-standalone bison bsd-compat-headers bzip2-dev curl curl-dev flex-dev libtool linux-headers musl-fts-dev \
    musl-libintl musl-obstack-dev xz-dev zlib-dev zstd-dev && \
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

# Copy run.sh and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set entrypoint
ENTRYPOINT ["/app/run.sh"]