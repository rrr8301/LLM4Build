# Dockerfile
FROM node:14

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Create work directory
WORKDIR /usr/src/app

# Copy repository files
COPY . .

# Install dependencies
RUN npm ci

# Copy run.sh and make it executable
COPY run.sh /usr/src/app/run.sh
RUN chmod +x /usr/src/app/run.sh

# Set run.sh as the entrypoint
ENTRYPOINT ["/usr/src/app/run.sh"]