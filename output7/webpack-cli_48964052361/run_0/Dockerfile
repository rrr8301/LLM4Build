# Use the base image
FROM ubuntu:22.04

# Set the timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install curl and Node.js
RUN apt-get update && apt-get install -y curl \
    && curl -fsSL https://deb.nodesource.com/setup_18.x | bash - \
    && apt-get install -y nodejs

# Install yarn and pnpm
RUN npm install -g yarn pnpm@9

# Create and set the working directory
WORKDIR /app

# Copy the repository contents
COPY . .

# Install project dependencies
RUN yarn --frozen-lockfile --ignore-engines --ignore-scripts

# Build the environment for tests
RUN yarn build:ci

# Copy the run.sh script and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set the entrypoint to run.sh
ENTRYPOINT ["/app/run.sh"]