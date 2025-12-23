FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install dependencies
RUN apt-get update && apt-get install -y \
    curl \
    wget \
    git \
    make \
    gcc \
    && rm -rf /var/lib/apt/lists/*

# Install Go
RUN curl -sSL https://golang.org/dl/go1.21.1.linux-amd64.tar.gz | tar -C /usr/local -xz
ENV PATH="/usr/local/go/bin:${PATH}"

# Create work directory
WORKDIR /app

# Copy repository
COPY . .

# Modify linux-setup.sh to remove sudo
RUN sed -i 's/sudo //g' .github/workflows/linux-setup.sh

# Run linux-setup.sh to install Docker and other dependencies
RUN chmod +x .github/workflows/linux-setup.sh && ./.github/workflows/linux-setup.sh

# Copy run.sh and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set entrypoint
ENTRYPOINT ["/app/run.sh"]