# Use Ubuntu as the base image
FROM ubuntu:22.04

# Set the timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install system dependencies
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    git \
    && apt-get clean

# Install Python testing dependencies
RUN pip3 install pytest

# Set the working directory
WORKDIR /app

# Copy the repository into the container
COPY . .

# Ensure the requirements.txt file is in the correct location
# If it's in a subdirectory, adjust the path accordingly
RUN if [ -f requirements.txt ]; then pip3 install -r requirements.txt; else echo "requirements.txt not found"; fi

# Copy the run.sh script and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set the entrypoint to run.sh
ENTRYPOINT ["/app/run.sh"]