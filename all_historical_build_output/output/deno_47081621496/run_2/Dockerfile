FROM ubuntu:24.04

# Install OS-level dependencies
RUN apt-get update && \
    apt-get install -y git curl wget xz-utils clang-19 lld-19 clang-tools-19 clang-format-19 clang-tidy-19 unzip software-properties-common && \
    apt-get clean

# Install Deno
RUN curl -fsSL https://deno.land/install.sh | sh

# Install Node.js
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - && \
    apt-get install -y nodejs

# Add deadsnakes PPA for Python 3.11
RUN add-apt-repository ppa:deadsnakes/ppa && \
    apt-get update && \
    apt-get install -y python3.11 python3.11-venv python3.11-dev

# Set environment variables
ENV PATH="/root/.deno/bin:${PATH}"

# Copy the repository
COPY . /app
WORKDIR /app

# Copy and set permissions for run.sh
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set entrypoint
ENTRYPOINT ["/app/run.sh"]