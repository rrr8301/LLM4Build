# Dockerfile
FROM golang:1.21-bullseye

# Set the timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install necessary packages
RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    dos2unix \
    && rm -rf /var/lib/apt/lists/*

# Create work directory
WORKDIR /app

# Copy the repository contents
COPY . .

# Install yamlfmt
RUN go install github.com/google/yamlfmt/cmd/yamlfmt@latest

# Copy the run.sh script and make it executable
COPY run.sh /app/run.sh
RUN dos2unix /app/run.sh && chmod +x /app/run.sh

# Set the entrypoint
ENTRYPOINT ["/app/run.sh"]