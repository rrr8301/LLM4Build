# Use Node.js 22 base image
FROM node:22-bullseye

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Create and set working directory
WORKDIR /usr/src/app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code
COPY . .

# Make run.sh executable and set as entrypoint
COPY run.sh /usr/src/app/run.sh
RUN chmod +x /usr/src/app/run.sh
ENTRYPOINT ["/usr/src/app/run.sh"]