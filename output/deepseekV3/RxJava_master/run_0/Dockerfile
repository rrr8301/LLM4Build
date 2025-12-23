# Use official Eclipse Temurin JDK 17 image
FROM eclipse-temurin:17-jdk

# Set timezone to Pacific Time non-interactively
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    make \
    g++ \
    python3 \
    python3-pip \
    && rm -rf /var/lib/apt/lists/*

# Install Python packages for testing
RUN pip3 install pytest

# Create and set working directory
WORKDIR /rxjava

# Copy repository files
COPY . .

# Make run.sh executable
RUN chmod +x run.sh

# Set entrypoint
ENTRYPOINT ["/rxjava/run.sh"]