FROM ubuntu:latest

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install OS-level dependencies including apt-utils to avoid debconf warnings
RUN apt-get update && apt-get install -y \
    apt-utils \
    shared-mime-info \
    curl \
    zip \
    make \
    git \
    ca-certificates \
    docker.io

# Install Go using the official method
RUN curl -fsSL https://dl.google.com/go/go1.21.0.linux-amd64.tar.gz -o go.tar.gz \
    && tar -C /usr/local -xzf go.tar.gz \
    && rm go.tar.gz
ENV PATH="/usr/local/go/bin:${PATH}"
ENV GOPATH="/go"

# Install Node.js
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - \
    && apt-get install -y nodejs

# Create work directory
WORKDIR /app

# Copy repository
COPY . .

# Install Node.js dependencies
RUN cd console/frontend && npm install

# Copy run.sh and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set entrypoint
ENTRYPOINT ["/app/run.sh"]