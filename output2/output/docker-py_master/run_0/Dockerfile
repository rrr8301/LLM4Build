# Use the base image
FROM ubuntu:22.04

# Set the timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install Python and pip
RUN apt-get update && \
    apt-get install -y python3.11 python3-pip make && \
    apt-get clean

# Set the working directory
WORKDIR /app

# Copy the repository into the container
COPY . .

# Install Python dependencies
RUN python3 -m pip install --upgrade pip && \
    pip3 install '.[ssh,dev]' && \
    pip3 install build

# Copy the run.sh script and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set the entrypoint to run.sh
ENTRYPOINT ["/app/run.sh"]