# Use the official Ubuntu base image
FROM ubuntu:latest

# Set the timezone to Pacific Time (America/Los_Angeles)
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install necessary packages
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    git \
    wget \
    ca-certificates && \
    rm -rf /var/lib/apt/lists/*

# Install Go
RUN wget https://golang.org/dl/go1.20.5.linux-amd64.tar.gz && \
    tar -C /usr/local -xzf go1.20.5.linux-amd64.tar.gz && \
    rm go1.20.5.linux-amd64.tar.gz

# Set Go environment variables
ENV PATH="/usr/local/go/bin:${PATH}"

# Create a work directory
WORKDIR /app

# Copy the repository into the container
COPY . .

# Copy the run.sh script and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set the entrypoint to run.sh
ENTRYPOINT ["/app/run.sh"]