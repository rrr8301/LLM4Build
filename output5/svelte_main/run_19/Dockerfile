FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install necessary packages
RUN apt-get update && apt-get install -y \
    curl \
    git \
    && rm -rf /var/lib/apt/lists/*

# Install Node.js (compatible with npm@11.5.2)
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get install -y nodejs

# Update npm to a version that supports workspaces
RUN npm install -g npm@9.0.0  # Ensure npm version supports workspaces

# Create app directory
WORKDIR /usr/src/app

# Copy the repository content
COPY . .

# Install dependencies with workspaces support
RUN npm install --legacy-peer-deps --workspaces

# Copy run.sh and make it executable
COPY run.sh /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh

# Set the entrypoint
ENTRYPOINT ["/usr/local/bin/run.sh"]