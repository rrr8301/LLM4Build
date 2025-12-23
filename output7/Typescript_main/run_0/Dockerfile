# Step 2: Infer the base image
FROM ubuntu:22.04

# Step 8: Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Step 4: Install required packages
RUN apt-get update && \
    apt-get install -y curl gnupg && \
    curl -fsSL https://deb.nodesource.com/setup_16.x | bash - && \
    apt-get install -y nodejs

# Step 4: Install npm global packages
RUN npm install -g hereby

# Step 8: Create work directory
WORKDIR /app

# Step 8: Copy repository contents
COPY . .

# Step 8: Install project dependencies
RUN npm ci

# Step 8: Copy run.sh, make it executable, and set as entrypoint
COPY run.sh /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh
ENTRYPOINT ["/usr/local/bin/run.sh"]