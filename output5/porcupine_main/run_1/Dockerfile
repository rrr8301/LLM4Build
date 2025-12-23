# Dockerfile
FROM golang:1.20-bullseye

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install git
RUN apt-get update && apt-get install -y git

# Create work directory
WORKDIR /app

# Copy the repository into the container
COPY . .

# Download Go module dependencies
RUN go mod download

# Copy run.sh and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set the entrypoint
ENTRYPOINT ["/app/run.sh"]