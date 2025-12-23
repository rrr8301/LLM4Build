FROM debian:11

# Install necessary packages
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    git \
    sudo && \
    rm -rf /var/lib/apt/lists/*

# Create a user 'builder'
RUN useradd builder --create-home

# Set environment variables
ENV DEVELOPER=1
ENV CUSTOM_PATH=/custom

# Copy the repository into the container
COPY . /app
WORKDIR /app

# Change ownership to 'builder'
RUN chown -R builder /app

# Copy and set permissions for the run script
COPY run.sh /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh

# Set the entrypoint
ENTRYPOINT ["/usr/local/bin/run.sh"]