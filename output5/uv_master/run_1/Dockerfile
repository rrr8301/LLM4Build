# Use the base image
FROM ubuntu:22.04

# Set the timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install Python and pip
RUN apt-get update && \
    apt-get install -y python3 python3-venv python3-pip && \
    apt-get clean

# Create a working directory
WORKDIR /app

# Copy the repository files
COPY . .

# Install Python dependencies
RUN pip install -r requirements.txt

# Copy the run.sh script and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set the entrypoint to run.sh
ENTRYPOINT ["/app/run.sh"]