# Use Node.js 18 on Debian Bullseye as the base image
FROM node:18-bullseye

# Set the timezone to Pacific Time (America/Los_Angeles)
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install git
RUN apt-get update && apt-get install -y git

# Create a working directory
WORKDIR /app

# Copy the repository contents into the container
COPY . .

# Install the zx package globally
RUN npm install -g zx

# Copy the run.sh script and make it executable
COPY run.sh /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh

# Set the entrypoint to run.sh
ENTRYPOINT ["/usr/local/bin/run.sh"]