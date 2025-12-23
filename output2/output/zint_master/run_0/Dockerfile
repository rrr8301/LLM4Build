# Dockerfile
FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install dependencies
RUN apt-get update && apt-get install -y \
    libpng-dev \
    make \
    git \
    cmake \
    build-essential \
    qt5-default \
    locales

# Set locale
RUN locale-gen de_DE.UTF-8 && update-locale

# Clone and install GS1 Syntax Engine
RUN git clone --depth=1 https://github.com/gs1/gs1-syntax-engine && \
    cd gs1-syntax-engine/src/c-lib && \
    make lib && make install

# Create work directory
WORKDIR /app

# Copy repository
COPY . .

# Create build directory
RUN cmake -E make_directory build

# Copy run.sh, make it executable and set as entrypoint
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh
ENTRYPOINT ["/app/run.sh"]