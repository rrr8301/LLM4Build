# Use official Python 3.12 image based on Debian 12
FROM python:3.12-slim-bookworm

# Set timezone to Pacific Time non-interactively
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install system dependencies including g++ for C++ compilation
RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    build-essential \
    g++ \
    && rm -rf /var/lib/apt/lists/*

# Create and set working directory
WORKDIR /app

# First install setuptools (which includes pkg_resources) and packaging
RUN pip install --upgrade pip setuptools packaging

# Copy requirements first to leverage Docker cache
COPY preview/requirements.txt .
# Validate and fix requirements format before installing
RUN sed -i 's/watchdog==2.1./watchdog==2.1/' requirements.txt
# Use modern alternative to pkg_resources
RUN python -c "from packaging.requirements import Requirement; [Requirement(line.strip()) for line in open('requirements.txt') if line.strip() and not line.strip().startswith('#')]"
RUN pip install --no-cache-dir --root-user-action=ignore -r requirements.txt

# Copy repository contents including test files and cpp files
COPY . .

# Make run.sh executable
RUN chmod +x /app/run.sh

# Set entrypoint
ENTRYPOINT ["/app/run.sh"]