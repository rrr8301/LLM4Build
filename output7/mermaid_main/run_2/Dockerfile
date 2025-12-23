FROM node:20

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles

# Install tzdata and set timezone non-interactively
RUN apt-get update && \
    apt-get install -y tzdata && \
    ln -fs /usr/share/zoneinfo/$TZ /etc/localtime && \
    dpkg-reconfigure -f noninteractive tzdata && \
    apt-get clean

# Install pnpm
RUN npm install -g pnpm

# Create and set working directory
WORKDIR /app

# Copy the repository content
COPY . .

# Install project dependencies with pnpm
RUN pnpm install --legacy-peer-deps

# Copy run.sh and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set the entrypoint
ENTRYPOINT ["/app/run.sh"]