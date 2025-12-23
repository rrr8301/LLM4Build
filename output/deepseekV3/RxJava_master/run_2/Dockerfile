# Use official Eclipse Temurin JDK 17 image
FROM eclipse-temurin:17-jdk

# Set timezone to Pacific Time non-interactively
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install system dependencies including Java 8 for Gradle toolchain
RUN apt-get update && apt-get install -y \
    git \
    make \
    g++ \
    python3 \
    python3-pip \
    python3-venv \
    openjdk-8-jdk \
    && rm -rf /var/lib/apt/lists/*

# Create and set working directory
WORKDIR /rxjava

# Copy repository files
COPY . .

# Create Python virtual environment and install pytest
RUN python3 -m venv /venv && \
    /venv/bin/pip install pytest pytest-cov

# Make run.sh executable
RUN chmod +x run.sh

# Set entrypoint
ENTRYPOINT ["/rxjava/run.sh"]