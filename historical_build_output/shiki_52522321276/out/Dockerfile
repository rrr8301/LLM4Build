# Use the latest Ubuntu as the base image
FROM ubuntu:latest

# Set the timezone to Pacific Time (America/Los_Angeles)
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install necessary packages
RUN apt-get update && \
    apt-get install -y curl && \
    curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get install -y nodejs && \
    npm install -g pnpm @antfu/ni

# Create and set the working directory
WORKDIR /usr/src/app

# Copy the repository contents into the container
COPY . .

# Install project dependencies
RUN nci

# Copy the run.sh script and make it executable
COPY run.sh /usr/src/app/run.sh
RUN chmod +x /usr/src/app/run.sh

# Set the entrypoint to run.sh
ENTRYPOINT ["/usr/src/app/run.sh"]