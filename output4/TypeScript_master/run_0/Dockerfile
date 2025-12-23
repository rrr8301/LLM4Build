# Use the official Ubuntu 22.04 as a parent image
FROM ubuntu:22.04

# Set the timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install curl to download Node.js
RUN apt-get update && apt-get install -y curl

# Install Node.js 20
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get install -y nodejs

# Create app directory
WORKDIR /usr/src/app

# Copy the repository files into the container
COPY . .

# Install npm dependencies
RUN npm ci

# Copy run.sh and make it executable
COPY run.sh /usr/src/app/run.sh
RUN chmod +x /usr/src/app/run.sh

# Set the entrypoint to run.sh
ENTRYPOINT ["/usr/src/app/run.sh"]