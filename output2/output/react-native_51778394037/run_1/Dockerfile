# Dockerfile
FROM reactnativecommunity/react-native-android:latest

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install dependencies
RUN apt-get update && apt-get install -y \
    git \
    cmake \
    openssl \
    libssl-dev \
    clang \
    dos2unix

# Create work directory
WORKDIR /app

# Copy repository contents
COPY . .

# Install Node.js version 22.14.0
RUN npm install -g n && n 22.14.0

# Install yarn
RUN npm install -g yarn

# Install Node.js dependencies
RUN yarn install --non-interactive --frozen-lockfile

# Copy run.sh and make it executable
COPY run.sh /app/run.sh
RUN dos2unix /app/run.sh && chmod +x /app/run.sh

# Set entrypoint
ENTRYPOINT ["/app/run.sh"]