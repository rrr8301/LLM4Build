# Use the base image
FROM ubuntu:22.04

# Set the timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install dependencies
RUN apt-get update && apt-get install -y \
    curl \
    git \
    gcc \
    make \
    && rm -rf /var/lib/apt/lists/*

# Install Go
RUN curl -sSL https://golang.org/dl/go1.17.6.linux-amd64.tar.gz | tar -C /usr/local -xz
ENV PATH="/usr/local/go/bin:${PATH}"

# Set GOPATH
ENV GOPATH=/go
ENV PATH="${GOPATH}/bin:${PATH}"

# Create work directory
WORKDIR /app

# Copy the repository
COPY . .

# Install Go dependencies
RUN go mod download

# Install godog
RUN go install github.com/cucumber/godog/cmd/godog@latest

# Copy run.sh, make it executable, and set as entrypoint
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh
ENTRYPOINT ["/app/run.sh"]