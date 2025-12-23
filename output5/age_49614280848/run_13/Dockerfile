# Dockerfile
FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    build-essential \
    libreadline-dev \
    zlib1g-dev \
    flex \
    bison \
    git \
    dos2unix \
    libicu-dev \
    pkg-config \
    libssl-dev \
    libxml2-dev \
    libxslt1-dev \
    libedit-dev \
    libperl-dev \
    libpython3-dev \
    tcl-dev \
    uuid-dev \
    locales && \
    rm -rf /var/lib/apt/lists/*

# Set locale to ensure UTF-8 support
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# Create a non-root user
RUN useradd -m -s /bin/bash postgres_user

# Create work directory and set permissions
WORKDIR /workspace
RUN chown postgres_user:postgres_user /workspace

# Copy run.sh and make it executable as root
COPY run.sh /workspace/run.sh
RUN dos2unix /workspace/run.sh && chmod +x /workspace/run.sh

# Switch to the non-root user
USER postgres_user

# Configure Git to skip SSL verification for the non-root user
RUN git config --global http.sslVerify false

# Clone the repository
RUN git clone https://github.com/apache/age.git .

# Set entrypoint
ENTRYPOINT ["/bin/bash", "/workspace/run.sh"]