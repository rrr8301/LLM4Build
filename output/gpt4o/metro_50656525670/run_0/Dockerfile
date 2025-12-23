# Dockerfile
FROM node:20.19.4-bullseye

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install necessary packages
RUN apt-get update && apt-get install -y git

# Create and set working directory
WORKDIR /usr/src/app

# Copy repository files
COPY . .

# Install Yarn globally
RUN npm install -g yarn

# Install project dependencies
RUN yarn install --frozen-lockfile --non-interactive --ignore-scripts

# Copy run.sh and make it executable
COPY run.sh /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh

# Set entrypoint
ENTRYPOINT ["/usr/local/bin/run.sh"]