# Dockerfile
FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    curl \
    git \
    build-essential \
    libssl-dev \
    zlib1g-dev \
    libreadline-dev \
    libyaml-dev \
    libsqlite3-dev \
    sqlite3 \
    libxml2-dev \
    libxslt1-dev \
    libcurl4-openssl-dev \
    software-properties-common \
    libffi-dev \
    gnupg2 && \
    rm -rf /var/lib/apt/lists/*

# Manually add the GPG key and repository for Ruby
RUN curl -fsSL https://keyserver.ubuntu.com/pks/lookup?op=get&search=0xFC1E65C4D60181C7E0A0116F8872ED2718602E9E | gpg --dearmor -o /usr/share/keyrings/brightbox.gpg && \
    echo "deb [signed-by=/usr/share/keyrings/brightbox.gpg] https://ppa.launchpadcontent.net/brightbox/ruby-ng/ubuntu jammy main" > /etc/apt/sources.list.d/brightbox.list

# Install Ruby
RUN apt-get update && \
    apt-get install -y ruby3.2 ruby3.2-dev && \
    gem install bundler

# Create work directory
WORKDIR /app

# Copy repository
COPY . .

# Install Ruby packages
RUN bundle install

# Copy run.sh and make it executable
COPY run.sh /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh

# Set entrypoint
ENTRYPOINT ["/usr/local/bin/run.sh"]