FROM ubuntu:latest

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install OS-level dependencies
RUN apt-get update && \
    apt-get install -y python3.13 python3.13-venv python3-pip git && \
    apt-get clean

# Create a working directory
WORKDIR /app

# Copy the repository contents
COPY . .

# Install Python dependencies
RUN python3.13 -m venv venv && \
    . venv/bin/activate && \
    pip install --upgrade pip && \
    pip install --upgrade --requirement requirements_test.txt

# Copy run.sh and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set the entrypoint
ENTRYPOINT ["/app/run.sh"]