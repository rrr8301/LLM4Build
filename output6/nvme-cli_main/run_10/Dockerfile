# Dockerfile
FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install OS-level dependencies
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    build-essential \
    gcc \
    meson \
    ninja-build \
    && apt-get clean

# Set work directory
WORKDIR /app

# Copy only the necessary files first to leverage Docker cache
COPY requirements.txt .

# Ensure requirements.txt is present
RUN if [ ! -f requirements.txt ]; then echo "requirements.txt not found"; exit 1; fi

# Install Python dependencies
RUN pip3 install -r requirements.txt

# Copy the rest of the application code
COPY . .

# Copy run.sh and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set entrypoint
ENTRYPOINT ["/app/run.sh"]