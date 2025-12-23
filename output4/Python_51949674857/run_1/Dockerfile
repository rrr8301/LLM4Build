FROM ubuntu:latest

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install dependencies
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    git \
    curl

# Create work directory
WORKDIR /app

# Copy repository
COPY . .

# Install UV and Python dependencies
# Use a direct method to install UV if the curl method fails
RUN git clone https://github.com/astral-sh/uv.git /tmp/uv && \
    cd /tmp/uv && \
    ./install.sh && \
    rm -rf /tmp/uv

# Copy run.sh and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set entrypoint
ENTRYPOINT ["/app/run.sh"]