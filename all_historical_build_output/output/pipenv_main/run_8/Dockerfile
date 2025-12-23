FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Set the LANG environment variable
ENV LANG=C.UTF-8

# Install system dependencies
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    git \
    && apt-get clean

# Install pipenv
RUN pip3 install pipenv

# Create and set the working directory
WORKDIR /app

# Copy the repository contents into the container
COPY . .

# Ensure the Pipfile is valid before installing dependencies
# Remove --skip-lock if you want to ensure dependencies are locked
RUN pipenv install --dev --skip-lock

# Copy the run.sh script and make it executable
COPY run.sh /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh

# Set the entrypoint to run.sh
ENTRYPOINT ["/usr/local/bin/run.sh"]