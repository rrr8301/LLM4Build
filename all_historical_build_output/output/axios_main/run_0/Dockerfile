# Use a suitable base image
FROM node:18

# Set the timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install any required OS-level packages
RUN apt-get update && apt-get install -y \
    # Add any additional packages here
    && rm -rf /var/lib/apt/lists/*

# Create a working directory
WORKDIR /usr/src/app

# Copy the repository files
COPY . .

# Install Node.js dependencies
RUN npm install

# Copy the run.sh script and make it executable
COPY run.sh /usr/src/app/run.sh
RUN chmod +x /usr/src/app/run.sh

# Set the entrypoint to run.sh
ENTRYPOINT ["/usr/src/app/run.sh"]