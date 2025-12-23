FROM eclipse-temurin:21-jdk

# Install unzip for Maven wrapper if needed
RUN apt-get update && apt-get install -y --no-install-recommends unzip ca-certificates && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Copy the entire repo into /app
COPY . /app

# Copy run.sh and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

ENTRYPOINT ["/app/run.sh"]