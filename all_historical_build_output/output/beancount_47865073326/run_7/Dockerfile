FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install dependencies
RUN apt-get update && \
    apt-get install -y python3.11 python3.11-venv python3-pip meson ninja-build bison flex pkg-config && \
    apt-get clean

# Create work directory
WORKDIR /app

# Copy repository contents
COPY . .

# Install Python packages
RUN python3.11 -m pip install --upgrade pip && \
    python3.11 -m pip install meson-python ninja pytest

# Copy run.sh and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set entrypoint
ENTRYPOINT ["/app/run.sh"]