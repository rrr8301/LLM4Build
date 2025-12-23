# Use official Temurin JDK 17 image
FROM eclipse-temurin:17-jdk-jammy

# Set timezone to Pacific Time non-interactively
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install required packages
RUN apt-get update && apt-get install -y \
    git \
    maven \
    && rm -rf /var/lib/apt/lists/*

# Create working directory
WORKDIR /workspace

# Copy repository contents
COPY . .

# Make run.sh executable and set as entrypoint
COPY run.sh /run.sh
RUN chmod +x /run.sh
ENTRYPOINT ["/run.sh"]