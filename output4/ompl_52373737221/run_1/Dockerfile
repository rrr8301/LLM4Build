FROM ubuntu:latest

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install dependencies
RUN apt-get update -y -qq && \
    apt-get install -y -qq \
    libboost-program-options-dev \
    libboost-serialization-dev \
    libboost-test-dev \
    libeigen3-dev \
    libflann-dev \
    libtriangle-dev \
    libyaml-cpp-dev \
    cmake \
    make \
    g++ \
    git \
    wget

# Install OMPL
RUN apt-get install -y -qq python3-pip && \
    pip install --upgrade pip && \
    pip install ompl

# Create work directory
WORKDIR /app

# Copy repository contents
COPY . .

# Copy run.sh and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set entrypoint
ENTRYPOINT ["/app/run.sh"]