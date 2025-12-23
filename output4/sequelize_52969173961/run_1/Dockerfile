# Dockerfile
FROM node:18-bullseye

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install tar for extracting artifacts
RUN apt-get update && apt-get install -y tar && apt-get clean

# Create and set working directory
WORKDIR /app

# Copy the repository into the container
COPY . .

# Check if the tar file exists and extract it if it does
RUN if [ -f install-build-node-18.tar ]; then tar -xf install-build-node-18.tar; fi

# Install project dependencies
RUN yarn install

# Copy run.sh and make it executable
COPY run.sh /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh

# Set the entrypoint
ENTRYPOINT ["/usr/local/bin/run.sh"]