# Dockerfile
FROM node:18-bullseye

# Set the timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install curl
RUN apt-get update && apt-get install -y curl

# Create a working directory
WORKDIR /usr/src/app

# Copy the repository files
COPY . .

# Install global npm package
RUN npm install -g @openai/codex

# Copy the run.sh script and make it executable
COPY run.sh /usr/src/app/run.sh
RUN dos2unix /usr/src/app/run.sh && chmod +x /usr/src/app/run.sh

# Set the entrypoint
ENTRYPOINT ["/usr/src/app/run.sh"]