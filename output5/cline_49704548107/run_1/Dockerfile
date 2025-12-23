# Use the official Ubuntu 22.04 as a parent image
FROM ubuntu:22.04

# Set the timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install necessary packages
RUN apt-get update && \
    apt-get install -y \
    curl \
    xvfb \
    python3.10 \
    python3-pip && \
    apt-get clean

# Remove conflicting package
RUN apt-get remove -y libnode-dev

# Set up Node.js
RUN curl -fsSL https://deb.nodesource.com/setup_22.x | bash - && \
    apt-get install -y nodejs

# Upgrade pip and install Python dependencies
RUN python3.10 -m pip install --upgrade pip && \
    pip install requests

# Create and set the working directory
WORKDIR /app

# Copy the repository files into the container
COPY . .

# Copy the run.sh script and make it executable
COPY run.sh /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh

# Set the entrypoint to run.sh
ENTRYPOINT ["/usr/local/bin/run.sh"]