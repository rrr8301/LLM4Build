FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install curl and Node.js
RUN apt-get update && apt-get install -y curl \
    && curl -fsSL https://deb.nodesource.com/setup_20.x | bash - \
    && apt-get install -y nodejs

# Install pnpm
RUN npm install -g pnpm

# Set up work directory
WORKDIR /app

# Copy repository contents
COPY . .

# Set up PNPM_HOME and add it to PATH
ENV PNPM_HOME=/root/.local/share/pnpm
ENV PATH=$PNPM_HOME:$PATH

# Set SHELL environment variable to bash
SHELL ["/bin/bash", "-c"]

# Explicitly set SHELL environment variable for pnpm
ENV SHELL=/bin/bash

# Run pnpm setup
RUN pnpm setup

# Install npm@8 globally using pnpm
RUN pnpm add --global npm@8

# Install project dependencies
RUN pnpm install

# Copy run.sh and make it executable
COPY run.sh /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh

# Set entrypoint
ENTRYPOINT ["/usr/local/bin/run.sh"]