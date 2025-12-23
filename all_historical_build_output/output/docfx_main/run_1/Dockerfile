FROM mcr.microsoft.com/dotnet/sdk:8.0

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install Node.js
RUN curl -fsSL https://deb.nodesource.com/setup_22.x | bash - && \
    apt-get install -y nodejs

# Install docfx as a global tool
RUN dotnet tool install -g docfx

# Create work directory
WORKDIR /app

# Copy repository contents
COPY . .

# Ensure package.json exists before running npm commands
RUN test -f package.json && npm install && npm run build || echo "package.json not found, skipping npm install and build"

# Copy run.sh and make it executable
COPY run.sh /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh

# Set entrypoint
ENTRYPOINT ["/usr/local/bin/run.sh"]