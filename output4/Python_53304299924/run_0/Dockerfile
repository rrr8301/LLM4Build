FROM ubuntu:latest

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install OS-level dependencies
RUN apt-get update && apt-get install -y \
    libhdf5-dev \
    python3.14 \
    python3.14-venv \
    python3.14-dev \
    python3-pip

# Create a working directory
WORKDIR /app

# Copy the repository into the container
COPY . .

# Install Python dependencies using uv
RUN pip install uv

# Copy run.sh and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set the entrypoint
ENTRYPOINT ["/app/run.sh"]