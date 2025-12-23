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
    postgresql \
    postgresql-server-dev-all \
    python3 \
    python3-pip \
    git \
    && rm -rf /var/lib/apt/lists/*

# Create a work directory
WORKDIR /app

# Copy the repository into the container
COPY . .

# Install Python dependencies if any
# RUN pip3 install -r requirements.txt

# Copy the run.sh script and make it executable
COPY run.sh /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh

# Set the entrypoint to run.sh
ENTRYPOINT ["/usr/local/bin/run.sh"]