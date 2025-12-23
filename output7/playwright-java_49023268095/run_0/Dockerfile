FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install required packages
RUN apt-get update && apt-get install -y \
    wget \
    unzip \
    curl \
    tzdata \
    && rm -rf /var/lib/apt/lists/*

# Install Zulu JDK 1.8
RUN wget -qO - https://repos.azul.com/azul-repo.key | apt-key add - && \
    echo "deb http://repos.azul.com/zulu/deb/ stable main" | tee /etc/apt/sources.list.d/zulu.list && \
    apt-get update && apt-get install -y zulu-8

# Install Maven
RUN apt-get update && apt-get install -y maven

# Create work directory
WORKDIR /app

# Copy repository contents
COPY . .

# Make run.sh executable
RUN chmod +x /app/run.sh

# Set entrypoint
ENTRYPOINT ["/app/run.sh"]