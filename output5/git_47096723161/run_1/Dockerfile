FROM i386/ubuntu:focal

# Install required packages
RUN apt-get update && \
    apt-get install -y libc6-amd64 lib64stdc++6 git sudo && \
    rm -rf /var/lib/apt/lists/*

# Create builder user
RUN useradd builder --create-home

# Set environment variables
ENV DEVELOPER=1
ENV CUSTOM_PATH=/custom

# Copy the repository into the container
COPY . /app
WORKDIR /app

# Make run.sh executable and set as entrypoint
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh
ENTRYPOINT ["/app/run.sh"]