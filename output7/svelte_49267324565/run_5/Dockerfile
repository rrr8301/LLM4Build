# Use Ubuntu as the base image
FROM ubuntu:22.04

# Set the timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install necessary packages
RUN apt-get update && apt-get install -y \
    curl \
    git \
    build-essential

# Install Node.js (using NodeSource)
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get install -y nodejs

# Install the latest version of npm that supports workspaces
RUN npm install -g npm@11.6.0

# Create a working directory
WORKDIR /usr/src/app

# Copy the repository contents into the container
COPY . .

# Install project dependencies
RUN npm install --legacy-peer-deps --no-audit --no-fund

# Copy the run.sh script and make it executable
COPY run.sh /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh

# Set the entrypoint to run.sh
ENTRYPOINT ["/usr/local/bin/run.sh"]