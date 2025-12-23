# Use Ubuntu 22.04 as the base image
FROM ubuntu:22.04

# Set the timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install necessary packages
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    wget \
    apt-transport-https \
    software-properties-common \
    && rm -rf /var/lib/apt/lists/*

# Install .NET SDK 8.0
RUN wget https://packages.microsoft.com/config/ubuntu/22.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb && \
    dpkg -i packages-microsoft-prod.deb && \
    rm packages-microsoft-prod.deb && \
    apt-get update && \
    apt-get install -y dotnet-sdk-8.0

# Optionally install PowerShell if you need to run .ps1 scripts
# RUN apt-get install -y powershell

# Create a working directory
WORKDIR /app

# Copy the repository contents into the container
COPY . .

# Copy the run.sh script and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set the entrypoint to run.sh
ENTRYPOINT ["/app/run.sh"]