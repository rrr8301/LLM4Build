# Dockerfile
FROM node:18-bullseye

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN apt-get update && apt-get install -y tzdata && \
    ln -fs /usr/share/zoneinfo/$TZ /etc/localtime && \
    dpkg-reconfigure -f noninteractive tzdata

# Install any additional OS-level packages if needed
RUN apt-get install -y git

# Create and set the working directory
WORKDIR /usr/src/app

# Copy the repository contents into the container
COPY . .

# Install Node.js dependencies
RUN npm install

# Copy the run.sh script and make it executable
COPY run.sh /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh

# Set the entrypoint to run.sh
ENTRYPOINT ["/usr/local/bin/run.sh"]