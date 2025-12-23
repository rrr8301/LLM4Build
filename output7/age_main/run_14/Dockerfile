# Use Ubuntu as the base image
FROM ubuntu:22.04

# Set the timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install required packages
RUN apt-get update && apt-get install -y \
    build-essential \
    libreadline-dev \
    zlib1g-dev \
    flex \
    bison \
    postgresql-14 \
    postgresql-contrib-14 \
    postgresql-server-dev-14 \
    git \
    && rm -rf /var/lib/apt/lists/*

# Create a non-root user and group if they don't exist
RUN getent group postgres || groupadd -r postgres
RUN id -u postgres &>/dev/null || useradd -r -g postgres postgres

# Create a working directory and set permissions
WORKDIR /app
RUN chown -R postgres:postgres /app

# Copy the repository into the container
COPY . .

# Ensure the correct PostgreSQL include paths are used
# Adjust the include path to match the installed PostgreSQL version
ENV CFLAGS="-I/usr/include/postgresql/14/server -I/usr/include/postgresql/14/internal -I/usr/include/postgresql"

# Copy the run.sh script and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Switch to the non-root user
USER postgres

# Set the entrypoint to run.sh
ENTRYPOINT ["/app/run.sh"]