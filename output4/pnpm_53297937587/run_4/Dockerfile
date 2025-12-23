FROM ubuntu:latest

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install necessary packages
RUN apt-get update && apt-get install -y curl git \
    && curl -fsSL https://deb.nodesource.com/setup_20.x | bash - \
    && apt-get install -y nodejs

# Install pnpm
RUN npm install -g pnpm

# Set SHELL environment variable
ENV SHELL=/bin/bash

# Create work directory
WORKDIR /app

# Copy repository contents
COPY . .

# Set up pnpm global bin directory
RUN pnpm setup

# Source the .bashrc to update the PATH
RUN . /root/.bashrc

# Install npm@8 globally
RUN pnpm add --global npm@8

# Install project dependencies
RUN pnpm install

# Copy run.sh and make it executable
COPY run.sh /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh

# Set entrypoint
ENTRYPOINT ["/usr/local/bin/run.sh"]