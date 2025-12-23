# Dockerfile
FROM node:lts

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Create and set working directory
WORKDIR /app

# Copy repository files
COPY . .

# Install project dependencies
RUN npm install

# Install specific npm packages
RUN npm install --ignore-scripts react-live@4 react@18 react-dom@18 @testing-library/react@14

# Copy run.sh and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set entrypoint
ENTRYPOINT ["/app/run.sh"]