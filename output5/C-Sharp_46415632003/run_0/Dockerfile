# Dockerfile
FROM mcr.microsoft.com/dotnet/sdk:8.0

# Set the timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Create a working directory
WORKDIR /app

# Copy the repository contents into the container
COPY . .

# Install project dependencies and build the project
RUN dotnet restore
RUN dotnet build --no-restore

# Copy the run.sh script, make it executable, and set it as the entrypoint
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh
ENTRYPOINT ["/app/run.sh"]