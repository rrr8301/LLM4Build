# Dockerfile
FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install necessary packages
RUN apt-get update && apt-get install -y \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Install Node.js
COPY .nvmrc /tmp/.nvmrc
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash \
    && . ~/.nvm/nvm.sh \
    && nvm install $(cat /tmp/.nvmrc) \
    && nvm use $(cat /tmp/.nvmrc) \
    && nvm alias default $(cat /tmp/.nvmrc)

# Create work directory
WORKDIR /app

# Copy repository
COPY . .

# Install project dependencies
RUN . ~/.nvm/nvm.sh && yarn install --immutable

# Copy run.sh and make it executable
COPY run.sh /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh

# Set entrypoint
ENTRYPOINT ["/usr/local/bin/run.sh"]