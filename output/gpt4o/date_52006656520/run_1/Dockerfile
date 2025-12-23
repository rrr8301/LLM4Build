# Use Ubuntu as the base image
FROM ubuntu:latest

# Set the timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install required packages including development tools
RUN apt-get update && \
    apt-get install -y git curl build-essential ruby-dev && \
    apt-get clean

# Install Ruby and Bundler
RUN apt-get install -y ruby-full && \
    gem install bundler

# Create a working directory and non-root user
WORKDIR /app
RUN useradd -m appuser && chown -R appuser /app
USER appuser

# Copy the repository into the container
COPY --chown=appuser . .

# Install Ruby dependencies
RUN bundle install --path vendor/bundle

# Copy the run.sh script and make it executable
COPY --chown=appuser run.sh /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh

# Set the entrypoint to run.sh
ENTRYPOINT ["/usr/local/bin/run.sh"]