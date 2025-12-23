FROM maven:3.8.6-openjdk-8

# Set working directory
WORKDIR /workspace

# Copy project files
COPY . /workspace

# Copy run script
COPY run.sh /workspace/run.sh

# Make run.sh executable
RUN chmod +x /workspace/run.sh

# Set entrypoint
ENTRYPOINT ["/workspace/run.sh"]