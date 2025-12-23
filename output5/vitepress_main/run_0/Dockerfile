# Dockerfile
FROM node:18-bullseye

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN apt-get update && apt-get install -y tzdata git \
    && ln -fs /usr/share/zoneinfo/$TZ /etc/localtime \
    && dpkg-reconfigure -f noninteractive tzdata

# Create and set working directory
WORKDIR /app

# Copy the repository content into the container
COPY . .

# Install project dependencies
RUN npm install

# Copy run.sh and make it executable
COPY run.sh /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh

# Set the entrypoint
ENTRYPOINT ["/usr/local/bin/run.sh"]