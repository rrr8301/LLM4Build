# Use official Maven/Java image
FROM maven:3.8.6-openjdk-11

# Set timezone to Pacific Time non-interactively
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Create working directory
WORKDIR /app

# Copy the entire project
COPY . .

# Install any additional system dependencies if needed
# (Not seeing any specific requirements in README)
RUN apt-get update && \
    apt-get install -y git && \
    rm -rf /var/lib/apt/lists/*

# Copy and make run.sh executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set entrypoint
ENTRYPOINT ["/app/run.sh"]