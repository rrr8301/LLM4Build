# Use BuildKit for building the image
# You can enable BuildKit by setting the environment variable DOCKER_BUILDKIT=1

FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install necessary packages
RUN apt-get update && apt-get install -y \
    curl \
    gnupg \
    && rm -rf /var/lib/apt/lists/*

# Install Node.js
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get install -y nodejs

# Update npm to the latest version
RUN npm install -g npm@latest

# Install Yarn
RUN npm install -g yarn

# Create and set work directory
WORKDIR /usr/src/app

# Copy package.json and yarn.lock first to leverage Docker cache
COPY package.json yarn.lock ./

# Install Node.js dependencies using yarn
# Temporarily disable frozen-lockfile to regenerate yarn.lock if needed
RUN yarn cache clean && yarn install --network-timeout 100000 || (rm -f yarn.lock && yarn install --network-timeout 100000)

# Copy the rest of the application files
COPY . .

# Copy run.sh and make it executable
COPY run.sh /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh

# Set entrypoint
ENTRYPOINT ["/usr/local/bin/run.sh"]