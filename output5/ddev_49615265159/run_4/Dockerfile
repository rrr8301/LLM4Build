# Dockerfile
FROM ubuntu:24.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install dependencies
RUN apt-get update && apt-get install -y \
    curl \
    git \
    build-essential \
    apt-utils \
    && rm -rf /var/lib/apt/lists/*

# Install Go
# Use the latest stable version of Go
RUN curl -sSL https://go.dev/dl/go1.21.1.linux-amd64.tar.gz | tar -C /usr/local -xz
ENV PATH="/usr/local/go/bin:${PATH}"

# Create work directory
WORKDIR /app

# Copy repository
COPY . .

# Install Docker and dependencies
# Remove 'sudo' from the script and replace 'brew' with 'apt-get'
RUN sed -i 's/sudo //g' ./.github/workflows/linux-setup.sh && \
    sed -i 's/brew install/apt-get install -y/g' ./.github/workflows/linux-setup.sh && \
    sed -i 's/brew tap/brew_tap_placeholder/g' ./.github/workflows/linux-setup.sh && \
    ./.github/workflows/linux-setup.sh

# Copy run.sh and make it executable
COPY run.sh /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh

# Set entrypoint
ENTRYPOINT ["/usr/local/bin/run.sh"]