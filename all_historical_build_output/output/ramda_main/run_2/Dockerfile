# Dockerfile
FROM node:18

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Create app directory
WORKDIR /usr/src/app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
# Use --legacy-peer-deps to handle potential peer dependency issues
RUN npm install --legacy-peer-deps || true

# Copy the rest of the application code
COPY . .

# Install Mocha globally for testing
RUN npm install -g mocha

# Copy run.sh and make it executable
COPY run.sh /usr/src/app/run.sh
RUN chmod +x /usr/src/app/run.sh

# Set the entrypoint
ENTRYPOINT ["/usr/src/app/run.sh"]