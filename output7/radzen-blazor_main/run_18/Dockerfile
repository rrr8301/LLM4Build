# Use the .NET 8.0 SDK image for building
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install git
RUN apt-get update && apt-get install -y git

# Create work directory
WORKDIR /app

# Copy the repository into the container
COPY . .

# Build the project targeting .NET 8.0
RUN dotnet build Radzen.Blazor/Radzen.Blazor.csproj -f net8.0

# Use the .NET 8.0 runtime image for running
FROM mcr.microsoft.com/dotnet/aspnet:8.0

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Create work directory
WORKDIR /app

# Copy the build output from the build stage
COPY --from=build /app .

# Copy run.sh and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set the entrypoint
ENTRYPOINT ["/app/run.sh"]