# Step 1: Infer the base image
FROM ubuntu:22.04

# Step 2: Set the timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Step 3: Install OS-level dependencies
RUN apt-get update && apt-get install -y \
    python3 \
    python3-venv \
    python3-pip \
    make \
    git \
    curl \
    && apt-get clean

# Step 4: Install Docker CLI (if needed for tests)
RUN curl -fsSL https://get.docker.com | sh

# Step 5: Create a working directory
WORKDIR /app

# Step 6: Copy the run.sh script and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Step 7: Set the entrypoint to run.sh
ENTRYPOINT ["/app/run.sh"]