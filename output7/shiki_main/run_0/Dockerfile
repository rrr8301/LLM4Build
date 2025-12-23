# Dockerfile
FROM node:18-bullseye

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN apt-get update && apt-get install -y tzdata && \
    ln -fs /usr/share/zoneinfo/$TZ /etc/localtime && \
    dpkg-reconfigure -f noninteractive tzdata

# Install git
RUN apt-get update && apt-get install -y git

# Create work directory
WORKDIR /usr/src/app

# Copy repository files
COPY . .

# Install project dependencies
RUN npm install

# Copy run.sh and make it executable
COPY run.sh /usr/src/app/run.sh
RUN chmod +x /usr/src/app/run.sh

# Set entrypoint
ENTRYPOINT ["/usr/src/app/run.sh"]