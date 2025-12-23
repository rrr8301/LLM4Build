# Dockerfile
FROM mcr.microsoft.com/dotnet/sdk:8.0

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Create and set work directory
WORKDIR /app

# Copy the entire repository into the container
COPY . .

# Install dependencies
RUN dotnet restore

# Copy run.sh, make it executable, and set as entrypoint
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh
ENTRYPOINT ["/app/run.sh"]