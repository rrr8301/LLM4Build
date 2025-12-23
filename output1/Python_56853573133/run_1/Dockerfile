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

# Copy only necessary files for dependency installation first
COPY pyproject.toml .
COPY uv.lock .  # if exists

# Install Python dependencies (using uv if available, otherwise pip)
# First check if requirements.txt exists, otherwise use pyproject.toml
RUN if [ -f "uv.lock" ]; then \
        pip install uv && \
        if [ -f "requirements.txt" ]; then \
            uv pip install -r requirements.txt; \
        else \
            uv pip install .; \
        fi; \
    else \
        if [ -f "requirements.txt" ]; then \
            pip install -r requirements.txt; \
        else \
            pip install .; \
        fi; \
    fi

# Copy the rest of the files
COPY . .

# Install project in development mode
RUN pip install -e .

# Copy and set up run script
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set entrypoint
ENTRYPOINT ["/app/run.sh"]