# Use a newer version of the official Golang image
FROM golang:1.21

# Set the Current Working Directory inside the container
WORKDIR /app

# Copy go.mod and go.sum files
COPY go.mod go.sum ./

# Download all dependencies. Dependencies will be cached if the go.mod and go.sum files are not changed
RUN go mod tidy || true

# Copy the source from the current directory to the Working Directory inside the container
COPY . .

# Install make
RUN apt-get update && apt-get install -y make && apt-get clean

# Ensure the Makefile has a build target
# Build the Go app
RUN if make -q build; then make build; else echo "No build target in Makefile"; fi

# Copy run.sh and make it executable
COPY run.sh /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh

# Command to run the executable
ENTRYPOINT ["/usr/local/bin/run.sh"]