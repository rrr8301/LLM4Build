FROM ubuntu:latest

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install dependencies
RUN apt-get update && apt-get install -y \
    git \
    make \
    curl

# Install Go
RUN curl -LO https://golang.org/dl/go1.17.6.linux-amd64.tar.gz && \
    tar -C /usr/local -xzf go1.17.6.linux-amd64.tar.gz && \
    rm go1.17.6.linux-amd64.tar.gz

# Set Go environment
ENV PATH="/usr/local/go/bin:${PATH}"

# Create work directory
WORKDIR /app

# Copy repository
COPY . .

# Install tparse
RUN go install github.com/mfridman/tparse@v0.18.0

# Copy run.sh and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set entrypoint
ENTRYPOINT ["/app/run.sh"]