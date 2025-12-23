# Use a suitable base image
FROM ubuntu:22.04

# Set the timezone to Pacific Time (America/Los_Angeles)
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install OS-level dependencies
RUN apt-get update && apt-get install -y \
    curl \
    git \
    nodejs \
    npm \
    && rm -rf /var/lib/apt/lists/*

# Create a working directory
WORKDIR /app

# Copy the repository into the container
COPY . .

# Install npm dependencies
RUN npm install

# Copy the run.sh script and make it executable
COPY run.sh /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh

# Set the entrypoint to run.sh
ENTRYPOINT ["/usr/local/bin/run.sh"]