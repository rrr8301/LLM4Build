# Dockerfile
# Use BuildKit for building the image
# You can enable BuildKit by setting the environment variable DOCKER_BUILDKIT=1 when building the image

FROM ubuntu:22.04

# Install necessary packages
RUN apt-get update && \
    apt-get install -y curl gnupg build-essential && \
    curl -fsSL https://deb.nodesource.com/setup_18.x | bash - && \
    apt-get install -y nodejs && \
    apt-get clean

# Verify Node.js and npm installation
RUN node -v && npm -v

# Create work directory
WORKDIR /app

# Copy the repository into the container
COPY . .

# Check if package.json exists before running npm install
RUN if [ -f package.json ]; then npm install --verbose || { echo "npm install failed"; exit 1; }; else echo "package.json not found"; exit 1; fi

# Copy run.sh and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set the entrypoint
ENTRYPOINT ["/app/run.sh"]