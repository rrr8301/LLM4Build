# Step 2: Infer the base image
FROM ubuntu:22.04

# Step 8: Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Step 4: Install required packages
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    python3 \
    python3-pip \
    python3-venv \
    git \
    && rm -rf /var/lib/apt/lists/*

# Step 8: Create work directory
WORKDIR /app

# Step 8: Copy repo
COPY . /app

# Step 8: Install packages
RUN pip install -e . && \
    pip install -r requirements.txt

# Step 8: Copy run.sh, make it executable and set as entrypoint
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh
ENTRYPOINT ["/app/run.sh"]