FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install dependencies
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    python3-venv \
    git \
    && apt-get clean

# Create work directory
WORKDIR /app

# Copy repository contents
COPY . .

# Set a pretend version for setuptools-scm
# Replace <normalized_dist_name> with the actual normalized distribution name
ENV SETUPTOOLS_SCM_PRETEND_VERSION_FOR_my_package=0.1.0

# Install Python dependencies
RUN python3 -m pip install --upgrade pip
RUN pip3 install '.[ssh,dev]'

# Copy run.sh and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set entrypoint
ENTRYPOINT ["/app/run.sh"]