# Use the .NET 9.0 SDK image for building
FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install git and .NET 8.0 runtime
RUN apt-get update && apt-get install -y git \
    && wget https://dotnet.microsoft.com/download/dotnet/thank-you/runtime-aspnetcore-8.0.0-linux-x64-binaries -O dotnet-runtime.tar.gz \
    && mkdir -p /usr/share/dotnet \
    && tar -zxf dotnet-runtime.tar.gz -C /usr/share/dotnet \
    && rm dotnet-runtime.tar.gz

# Create work directory
WORKDIR /app

# Copy the repository into the container
COPY . .

# Build the project targeting .NET 9.0
RUN dotnet build Radzen.Blazor/Radzen.Blazor.csproj -f net9.0

# Use the .NET 9.0 runtime image for running
FROM mcr.microsoft.com/dotnet/aspnet:9.0

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