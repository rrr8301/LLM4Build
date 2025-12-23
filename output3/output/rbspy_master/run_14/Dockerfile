FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install dependencies and CA certificates
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    curl \
    build-essential \
    libyaml-dev \
    libffi-dev \
    moreutils \
    autoconf \
    automake \
    libtool \
    gnupg2 \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Install Rust
RUN curl https://sh.rustup.rs -sSf | sh -s -- -y
ENV PATH="/root/.cargo/bin:${PATH}"

# Install RVM and Ruby
RUN curl -sSL https://rvm.io/mpapis.asc | gpg --import - && \
    curl -sSL https://rvm.io/pkuczynski.asc | gpg --import - && \
    curl -sSL https://get.rvm.io | bash -s stable

# Source RVM scripts and install Ruby
RUN /bin/bash -l -c "source /usr/local/rvm/scripts/rvm && rvm install ruby-3.0.0 && rvm use ruby-3.0.0 --default"

# Ensure RVM is in the PATH
ENV PATH="/usr/local/rvm/rubies/ruby-3.0.0/bin:/usr/local/rvm/bin:${PATH}"

# Create work directory
WORKDIR /app

# Copy repository
COPY . .

# Copy run.sh and make it executable
COPY run.sh /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh

# Set entrypoint
ENTRYPOINT ["/usr/local/bin/run.sh"]