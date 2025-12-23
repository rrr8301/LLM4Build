# Dockerfile
FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install OS-level dependencies
RUN apt-get update && apt-get install -y \
    python3.10 \
    python3.10-venv \
    python3.10-dev \
    python3-pip \
    curl \
    git \
    && apt-get clean

# Set up work directory
WORKDIR /app

# Copy the repository into the container
COPY . .

# Set a pretend version for setuptools-scm
ENV SETUPTOOLS_SCM_PRETEND_VERSION=0.1.0

# Install Python dependencies
RUN python3.10 -m pip install --upgrade pip && \
    pip install tox coverage

# Check if setup.py exists, otherwise use pyproject.toml
RUN if [ -f setup.py ]; then \
        python3.10 setup.py sdist; \
    elif [ -f pyproject.toml ]; then \
        python3.10 -m pip install build && \
        python3.10 -m build; \
    else \
        echo "No setup.py or pyproject.toml found"; \
        exit 1; \
    fi

# Copy run.sh and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set entrypoint
ENTRYPOINT ["/app/run.sh"]