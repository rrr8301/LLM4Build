FROM ubuntu:latest

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install system dependencies
RUN apt-get update && apt-get install -y \
    python3.12 \
    python3.12-venv \
    python3-pip \
    git

# Set up work directory
WORKDIR /app

# Create and activate virtual environment
RUN python3.12 -m venv /app/venv
ENV PATH="/app/venv/bin:$PATH"

# Copy repository contents
COPY . .

# Install Python dependencies using uv
RUN pip3 install --upgrade pip
RUN pip3 install uv
RUN uv pip install -r requirements-tests.txt
RUN uv pip install --upgrade "pydantic>=2.0.2,<3.0.0"

# Copy run.sh and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set entrypoint
ENTRYPOINT ["/app/run.sh"]