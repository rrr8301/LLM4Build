# Dockerfile
FROM node:20

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Create and set working directory
WORKDIR /usr/src/app

# Copy repository files
COPY . .

# Install latest npm
RUN npm install --global npm

# Install project dependencies
RUN npm ci

# Copy run.sh and make it executable
COPY run.sh /usr/src/app/run.sh
RUN chmod +x /usr/src/app/run.sh

# Set entrypoint
ENTRYPOINT ["/bin/bash", "/usr/src/app/run.sh"]