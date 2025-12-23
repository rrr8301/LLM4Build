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

# Install Python dependencies, skipping incompatible packages
RUN if [ -f "requirements.txt" ]; then \
        pip install -r requirements.txt; \
    else \
        pip install --no-deps --ignore-requires-python .; \
    fi

# Install test dependencies directly
RUN pip install pytest pytest-cov ruff

# Copy the rest of the files (excluding files in .dockerignore)
COPY . .

# Copy and set up run script
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set entrypoint
ENTRYPOINT ["/app/run.sh"]