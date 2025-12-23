# Use Temurin JDK 17 on Ubuntu 22.04 (jammy)
FROM eclipse-temurin:17-jdk-jammy

# Set timezone to Pacific Time non-interactively
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install required packages
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    maven \
    git && \
    rm -rf /var/lib/apt/lists/*

# Create and set working directory
WORKDIR /workspace

# Copy the repository (this will be done by the build context)
COPY . .

# Set entrypoint to our run script
COPY run.sh /run.sh
RUN chmod +x /run.sh
ENTRYPOINT ["/run.sh"]