FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install OS-level dependencies
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    git \
    make \
    gcc \
    && apt-get clean

# Set up the working directory
WORKDIR /app

# Copy the repository contents into the container
COPY . .

# Ensure the requirements.txt file is in the correct location
# If it's in a subdirectory, adjust the path accordingly
# For example, if it's in a folder named 'src', use COPY src/requirements.txt .
# This line is redundant if the file is already copied with the previous COPY command
# COPY requirements.txt .

# Install Python dependencies
RUN pip3 install -r requirements.txt

# Install pytest to run tests
RUN pip3 install pytest

# Copy the run.sh script and make it executable
COPY run.sh /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh

# Set the entrypoint to run.sh
ENTRYPOINT ["/usr/local/bin/run.sh"]