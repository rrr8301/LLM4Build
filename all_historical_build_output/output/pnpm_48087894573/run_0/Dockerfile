FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install required packages
RUN apt-get update && apt-get install -y \
    curl \
    git \
    && rm -rf /var/lib/apt/lists/*

# Install pnpm
RUN curl -f https://get.pnpm.io/v6.16.js | node - add --global pnpm

# Set up Node.js environment
RUN pnpm env use -g 22.12.0

# Install npm@8
RUN pnpm add --global npm@8

# Create work directory
WORKDIR /app

# Copy repository contents
COPY . .

# Install project dependencies
RUN pnpm install

# Copy run.sh and make it executable
COPY run.sh /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh

# Set entrypoint
ENTRYPOINT ["/usr/local/bin/run.sh"]