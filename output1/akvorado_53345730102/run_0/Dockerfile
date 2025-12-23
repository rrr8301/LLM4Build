# Use Ubuntu as the base image
FROM ubuntu:latest

# Set the timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install dependencies
RUN apt-get update && apt-get install -y \
    make \
    jq \
    curl \
    git \
    && rm -rf /var/lib/apt/lists/*

# Install Go
RUN curl -sSL https://golang.org/dl/go1.23.2.linux-amd64.tar.gz | tar -C /usr/local -xz
ENV PATH="/usr/local/go/bin:${PATH}"

# Create work directory
WORKDIR /app

# Copy the repository
COPY . .

# Install Go dependencies
RUN go mod download

# Copy run.sh and make it executable
COPY run.sh /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh

# Set the entrypoint
ENTRYPOINT ["/usr/local/bin/run.sh"]