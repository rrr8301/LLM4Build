# Dockerfile
FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install curl and unzip
RUN apt-get update && apt-get install -y curl unzip

# Install Deno
RUN curl -fsSL https://deno.land/install.sh | sh

# Set Deno binary path
ENV DENO_INSTALL="/root/.deno"
ENV PATH="$DENO_INSTALL/bin:$PATH"

# Create work directory
WORKDIR /app

# Copy the repository contents
COPY . .

# Ensure server.ts is present
# This step is not necessary if you ensure server.ts is in the build context
# RUN if [ ! -f /app/server.ts ]; then echo "server.ts not found in /app directory."; exit 1; fi

# Copy run.sh and make it executable
COPY run.sh /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh

# Set entrypoint
ENTRYPOINT ["/usr/local/bin/run.sh"]