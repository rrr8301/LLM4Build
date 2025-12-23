# Dockerfile
FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install necessary packages
RUN apt-get update && apt-get install -y \
    curl \
    gnupg \
    bash \
    && rm -rf /var/lib/apt/lists/*

# Set SHELL environment variable
SHELL ["/bin/bash", "-c"]

# Install pnpm
RUN curl -fsSL https://get.pnpm.io/install.sh | bash -

# Set PNPM_HOME and update PATH
ENV PNPM_HOME="/root/.local/share/pnpm"
ENV PATH="$PNPM_HOME:$PATH"

# Set up Node.js environment
RUN pnpm env use -g 20.0.0

# Install npm@8
RUN pnpm add --global npm@8

# Create work directory
WORKDIR /app

# Copy repository contents
COPY . .

# Ensure pnpm workspace is set up correctly
RUN pnpm install --recursive

# Copy run.sh and make it executable
COPY run.sh /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh

# Set entrypoint
ENTRYPOINT ["/usr/local/bin/run.sh"]