FROM ubuntu:24.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install dependencies
RUN apt-get update && \
    apt-get install -qy --no-install-recommends \
    bzip2 \
    curl \
    g++ \
    haskell-stack \
    libtinfo-dev \
    make \
    procps \
    zlib1g-dev \
    gdb \
    locales && \
    locale-gen en_US.UTF-8 && \
    echo "locales locales/default_environment_locale select en_US.UTF-8" | debconf-set-selections && \
    echo "locales locales/locales_to_be_generated multiselect en_US.UTF-8 UTF-8" | debconf-set-selections && \
    rm "/etc/locale.gen" && \
    dpkg-reconfigure --frontend noninteractive locales && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Create work directory
WORKDIR /app

# Copy repository code
COPY . .

# Copy run.sh and make it executable
COPY run.sh /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh

# Set entrypoint
ENTRYPOINT ["/usr/local/bin/run.sh"]