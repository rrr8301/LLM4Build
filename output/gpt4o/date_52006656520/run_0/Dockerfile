# Use Ubuntu as the base image
FROM ubuntu:latest

# Set the timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install required packages
RUN apt-get update && \
    apt-get install -y git curl && \
    apt-get clean

# Install Ruby and Bundler
RUN apt-get install -y ruby-full && \
    gem install bundler

# Create a working directory
WORKDIR /app

# Copy the repository into the container
COPY . .

# Install Ruby dependencies
RUN bundle install

# Copy the run.sh script and make it executable
COPY run.sh /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh

# Set the entrypoint to run.sh
ENTRYPOINT ["/usr/local/bin/run.sh"]