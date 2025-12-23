FROM ubuntu:latest

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install dependencies
RUN apt-get update && apt-get install -y \
    git \
    wget \
    unzip \
    && rm -rf /var/lib/apt/lists/*

# Install Go
RUN wget https://golang.org/dl/go1.17.linux-amd64.tar.gz && \
    tar -C /usr/local -xzf go1.17.linux-amd64.tar.gz && \
    rm go1.17.linux-amd64.tar.gz

ENV PATH="/usr/local/go/bin:${PATH}"

# Create work directory
WORKDIR /app

# Copy repository
COPY . .

# Install Go packages
RUN go install github.com/cucumber/godog/cmd/godog@latest
RUN go install honnef.co/go/tools/cmd/staticcheck@latest

# Copy run.sh and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set entrypoint
ENTRYPOINT ["/app/run.sh"]