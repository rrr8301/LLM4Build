# Use official Python image
FROM python:3.11-slim

# Set timezone to Pacific Time non-interactively
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Create working directory
WORKDIR /app

# Copy repository files
COPY . .

# Install Python dependencies (using uv if available, otherwise pip)
RUN if [ -f "uv.lock" ]; then \
        pip install uv && uv pip install -r requirements.txt; \
    else \
        pip install -r requirements.txt; \
    fi

# Install project in development mode
RUN pip install -e .

# Copy and set up run script
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set entrypoint
ENTRYPOINT ["/app/run.sh"]