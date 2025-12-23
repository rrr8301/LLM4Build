FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install system dependencies
RUN apt-get update && apt-get install -y \
    python3.10 \
    python3.10-venv \
    python3-pip \
    libgeos-dev \
    libpq-dev \
    libxml2-dev \
    libxslt1-dev \
    libz-dev \
    libexpat1 \
    make \
    && apt-get clean

# Set up work directory
WORKDIR /app

# Copy the repository
COPY . .

# Install Python dependencies
RUN pip3 install -r requirements.txt
RUN pip3 install -r requirements-standalone.txt
RUN pip3 install -r requirements-dev.txt
RUN pip3 install --upgrade https://github.com/geopython/OWSLib/archive/master.zip
RUN pip3 install tox

# Copy run.sh and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set entrypoint
ENTRYPOINT ["/app/run.sh"]