# Use Python 3.14 RC image as base
FROM python:3.14-rc-slim

# Set timezone to Pacific Time non-interactively
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install system dependencies including build tools and image processing libraries
RUN apt-get update && apt-get install -y \
    libhdf5-dev \
    git \
    g++ \
    make \
    libjpeg-dev \
    zlib1g-dev \
    libpng-dev \
    libtiff-dev \
    libwebp-dev \
    && rm -rf /var/lib/apt/lists/*

# Install UV
RUN pip install --no-cache-dir uv

# Create and set working directory
WORKDIR /app
COPY . .

# Install Python dependencies
RUN uv sync --group=test

# Copy and make run.sh executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set entrypoint
ENTRYPOINT ["/app/run.sh"]