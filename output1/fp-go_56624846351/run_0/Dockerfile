# Dockerfile
FROM golang:1.23

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Create work directory
WORKDIR /app

# Copy the repository
COPY . .

# Install Go dependencies
RUN go mod tidy

# Copy run.sh and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set run.sh as the entrypoint
ENTRYPOINT ["/app/run.sh"]