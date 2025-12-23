# Dockerfile
FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install necessary packages
RUN apt-get update && \
    apt-get install -y curl dos2unix && \
    curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get install -y nodejs && \
    apt-get clean

# Install Playwright dependencies
RUN apt-get update && \
    apt-get install -y libglib2.0-0 \
                       libnss3 \
                       libnspr4 \
                       libdbus-1-3 \
                       libatk1.0-0 \
                       libatk-bridge2.0-0 \
                       libatspi2.0-0 \
                       libx11-6 \
                       libxcomposite1 \
                       libxdamage1 \
                       libxext6 \
                       libxfixes3 \
                       libxrandr2 \
                       libgbm1 \
                       libxcb1 \
                       libxkbcommon0 \
                       libasound2 \
                       fonts-liberation \
                       libappindicator3-1 \
                       xdg-utils && \
    apt-get clean

# Create work directory
WORKDIR /app

# Copy repository files
COPY package.json package-lock.json ./

# Install npm dependencies
RUN npm ci

# Copy the rest of the application files
COPY . .

# Copy run.sh and make it executable
COPY run.sh /usr/local/bin/run.sh
RUN dos2unix /usr/local/bin/run.sh && chmod +x /usr/local/bin/run.sh

# Set entrypoint
ENTRYPOINT ["/bin/bash", "/usr/local/bin/run.sh"]