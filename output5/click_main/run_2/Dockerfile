# Step 1: Use a suitable base image
FROM ubuntu:22.04

# Step 2: Set the timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Step 3: Install OS-level dependencies
RUN apt-get update && apt-get install -y \
    python3 \
    python3-venv \
    python3-pip \
    git \
    && rm -rf /var/lib/apt/lists/*

# Step 4: Create a working directory
WORKDIR /app

# Step 5: Copy the repository into the container
COPY . /app

# Step 6: Copy the run.sh script and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Step 7: Set the entrypoint to run.sh
ENTRYPOINT ["/app/run.sh"]