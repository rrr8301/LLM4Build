# Step 1: Infer the base image
FROM ubuntu:22.04

# Step 2: Set the timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Step 3: Install OS-level dependencies
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    python3-venv \
    git \
    && rm -rf /var/lib/apt/lists/*

# Step 4: Create a working directory
WORKDIR /app

# Step 5: Copy the repository into the container
COPY . /app

# Step 6: Install Python dependencies
RUN pip3 install . \
    && pip3 install tox \
    && pip3 install pyink==24.3.0

# Step 7: Copy the run.sh script and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Step 8: Set the entrypoint
ENTRYPOINT ["/app/run.sh"]