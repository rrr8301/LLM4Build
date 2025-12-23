FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install Python 3 and other necessary packages
RUN apt-get update && \
    apt-get install -y python3 python3-pip sudo && \
    apt-get clean

# Create work directory
WORKDIR /app

# Copy the repository into the container
COPY . .

# Install system dependencies and build mvfst
RUN sudo python3 build/fbcode_builder/getdeps.py --allow-system-packages install-system-deps --recursive mvfst && \
    python3 build/fbcode_builder/getdeps.py --allow-system-packages build --src-dir=. mvfst --project-install-prefix mvfst:/usr/local

# Copy run.sh, make it executable, and set as entrypoint
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh
ENTRYPOINT ["/app/run.sh"]