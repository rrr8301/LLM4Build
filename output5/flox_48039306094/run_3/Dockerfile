FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install dependencies
RUN apt-get update && apt-get install -y \
    curl \
    git \
    psmisc \
    xz-utils \  # Added xz-utils for Nix installation
    && rm -rf /var/lib/apt/lists/*

# Install Nix
RUN curl -L https://nixos.org/nix/install | sh

# Install Just
RUN curl -fsSL https://just.systems/install.sh | bash -s -- --to /usr/local/bin

# Create work directory
WORKDIR /app

# Copy repository
COPY . .

# Copy run.sh and make it executable
COPY run.sh /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh

# Set entrypoint
ENTRYPOINT ["/usr/local/bin/run.sh"]