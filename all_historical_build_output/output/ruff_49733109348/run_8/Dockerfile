# Use the base image
FROM ubuntu:22.04

# Set the timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install dependencies
RUN apt-get update && apt-get install -y \
    curl \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Install Rust
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
ENV PATH="/root/.cargo/bin:${PATH}"

# Install mold
# Update the URL to the latest available version of mold
RUN curl -sSfL https://github.com/rui314/mold/releases/download/v1.15.2/mold-1.15.2-x86_64-linux.tar.gz | \
    tar xz -C /usr/local --strip-components=1 mold-1.15.2-x86_64-linux/bin/mold

# Install cargo-nextest and cargo-insta
RUN cargo install cargo-nextest cargo-insta

# Create work directory
WORKDIR /app

# Copy the repository
COPY . .

# Copy run.sh and make it executable
COPY run.sh /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh

# Set the entrypoint
ENTRYPOINT ["/usr/local/bin/run.sh"]