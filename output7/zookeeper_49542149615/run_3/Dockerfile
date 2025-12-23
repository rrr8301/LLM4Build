FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install necessary packages
RUN apt-get update && \
    apt-get install -y openjdk-11-jdk maven libcppunit-dev libsasl2-dev git && \
    apt-get clean

# Install additional packages that might be required for Javadoc generation
RUN apt-get install -y graphviz

# Create work directory
WORKDIR /app

# Copy the repository contents
COPY . .

# Copy the run.sh script and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set the entrypoint
ENTRYPOINT ["/app/run.sh"]