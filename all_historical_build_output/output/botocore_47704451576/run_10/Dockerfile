# Use BuildKit for building the image
# You can enable BuildKit by setting the environment variable DOCKER_BUILDKIT=1 when building the image

FROM python:3.9-slim-buster

# Install git and any other necessary packages
RUN apt-get update && \
    apt-get install -y --no-install-recommends git && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* || true

# Create work directory
WORKDIR /app

# Copy the repository
COPY . .

# Upgrade pip and install dependencies
RUN python -m pip install --no-cache-dir --upgrade pip
RUN python -m pip install --no-cache-dir -r requirements.txt

# Ensure python-dateutil, urllib3, and jmespath are installed
RUN python -m pip install --no-cache-dir python-dateutil urllib3 jmespath

# Copy run.sh and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set entrypoint
ENTRYPOINT ["/app/run.sh"]