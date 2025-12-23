# Use the .NET 9.0 SDK image
FROM mcr.microsoft.com/dotnet/sdk:9.0

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install git and .NET 8.0 runtime
RUN apt-get update && apt-get install -y git \
    && wget https://dotnet.microsoft.com/download/dotnet/thank-you/runtime-aspnetcore-8.0.0-linux-x64-binaries -O dotnet-runtime.tar.gz \
    && mkdir -p /usr/share/dotnet/shared/Microsoft.NETCore.App/8.0.0 \
    && tar -xzf dotnet-runtime.tar.gz -C /usr/share/dotnet/shared/Microsoft.NETCore.App/8.0.0 \
    && rm dotnet-runtime.tar.gz

# Create work directory
WORKDIR /app

# Copy the repository into the container
COPY . .

# Copy run.sh and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set the entrypoint
ENTRYPOINT ["/app/run.sh"]