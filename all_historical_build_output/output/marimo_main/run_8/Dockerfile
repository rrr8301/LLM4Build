# Use a base image that supports Python 3.12
FROM python:3.12

# Set the timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install necessary packages
RUN apt-get update && apt-get install -y \
    python3.12-venv \
    python3.12-dev \
    python3-distutils \
    git \
    curl \
    && apt-get clean

# Set up a working directory
WORKDIR /app

# Copy the repository contents into the container
COPY . .

# Install Hatch using pip
RUN python3.12 -m pip install --upgrade pip && \
    python3.12 -m pip install hatch

# Make run.sh executable and set it as the entrypoint
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh
ENTRYPOINT ["/app/run.sh"]