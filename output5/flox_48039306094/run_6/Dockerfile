FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install dependencies
RUN apt-get update && apt-get install -y \
    curl \
    git \
    psmisc \
    xz-utils \
    bash \
    && rm -rf /var/lib/apt/lists/*

# Install Nix
RUN mkdir -m 0755 /nix && \
    addgroup --system nixbld && \
    for i in $(seq 1 10); do \
        adduser --system --disabled-password --home /var/empty --gecos "Nix build user $i" \
        --ingroup nixbld --no-create-home nixbld$i; \
    done && \
    bash -c "sh <(curl -L https://nixos.org/nix/install) --no-daemon"

# Set up Nix environment
ENV USER=root
ENV PATH=/root/.nix-profile/bin:/nix/var/nix/profiles/default/bin:/bin:/sbin:/usr/bin:/usr/sbin
RUN bash -c ". /root/.nix-profile/etc/profile.d/nix.sh && nix-channel --update"

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