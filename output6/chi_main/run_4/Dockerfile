# Use the official Golang image as the base image
FROM golang:1.20

# Set the working directory inside the container
WORKDIR /app

# Copy the Go module files and download dependencies
COPY _examples/rest/go.mod _examples/rest/go.sum ./
RUN go mod download

# Copy the rest of the application source code
COPY _examples/rest/ .

# Build the Go application
RUN go build -o app

# Command to run the application
CMD ["./app"]