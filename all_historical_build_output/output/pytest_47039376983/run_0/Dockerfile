FROM python:3.12-slim

# Install OS dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    findutils \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy the entire repository (assumed current directory)
COPY . /app

# Upgrade pip and install tox and coverage
RUN python -m pip install --upgrade pip && \
    pip install tox coverage

# Copy run.sh and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

ENTRYPOINT ["/app/run.sh"]