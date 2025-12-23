# Dockerfile
FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install dependencies
RUN apt-get update && apt-get install -y \
    nginx \
    build-essential \
    libpcre3-dev \
    zlib1g-dev \
    libssl-dev \
    perl \
    cpanminus \
    && cpanm Test::More

# Create work directory
WORKDIR /app

# Copy the repository
COPY . .

# Build Nginx with the module
RUN ./auto/configure --add-module=/app && make && make install

# Copy run.sh, make it executable and set as entrypoint
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh
ENTRYPOINT ["/app/run.sh"]