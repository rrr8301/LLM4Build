FROM ubuntu:24.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install necessary packages
RUN apt-get update && apt-get install -y \
    libegl1 \
    libopengl0 \
    locales \
    && locale-gen en_US.UTF-8

# Set the locale
ENV LANG=C.UTF-8
ENV LC_ALL=C.UTF-8

# Create work directory
WORKDIR /app

# Copy the repository
COPY . .

# Install Conda and set up the environment
RUN bash -c "source /etc/profile.d/conda.sh && conda env create -f ci/deps/actions-311.yaml"

# Copy run.sh and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set entrypoint
ENTRYPOINT ["/app/run.sh"]