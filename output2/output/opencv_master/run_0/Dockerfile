# Dockerfile
FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install dependencies
RUN apt-get update && apt-get install -y \
    git \
    cmake \
    python3-numpy \
    python3-pip

# Create work directory
WORKDIR /app

# Copy repository contents
COPY . .

# Fetch opencv_contrib
RUN git clone --depth 1 https://github.com/opencv/opencv_contrib.git ../opencv_contrib

# Copy run.sh and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set entrypoint
ENTRYPOINT ["/app/run.sh"]