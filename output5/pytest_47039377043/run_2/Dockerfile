FROM ubuntu:22.04

# Set environment variables to avoid interactive prompts
ENV DEBIAN_FRONTEND=noninteractive
ENV LANG=C.UTF-8
ENV LC_ALL=C.UTF-8
ENV PYTHONUNBUFFERED=1

# Install Python 3.9 and build dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    python3.9 \
    python3.9-venv \
    python3.9-distutils \
    build-essential \
    curl \
    ca-certificates \
    git \
    bash \
    && rm -rf /var/lib/apt/lists/*

# Install pip for python3.9
RUN curl -sS https://bootstrap.pypa.io/get-pip.py | python3.9

# Create a symlink python -> python3.9 for convenience
RUN ln -sf /usr/bin/python3.9 /usr/bin/python

# Set working directory
WORKDIR /app

# Copy source code and dist directory (placeholders)
COPY . /app
# Remove this line because dist is inside the context and already copied by COPY . /app
# COPY dist /app/dist

# Upgrade pip and install tox and coverage
RUN python -m pip install --upgrade pip && \
    pip install tox coverage

# Copy run.sh and make executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

ENTRYPOINT ["/app/run.sh"]