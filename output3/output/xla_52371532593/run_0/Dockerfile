FROM us-central1-docker.pkg.dev/tpu-pytorch-releases/docker/development:3.12_tpuvm

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install Python dependencies
RUN pip install --no-cache-dir fsspec rich flax expecttest unittest-xml-reporting \
    torch_xla[pallas] --index-url https://us-python.pkg.dev/ml-oss-artifacts-published/jax/simple/ \
    --find-links https://storage.googleapis.com/jax-releases/libtpu_releases.html

# Install benchmark requirements if needed
COPY benchmarks/requirements.txt /tmp/benchmarks/requirements.txt
RUN pip install --no-cache-dir -r /tmp/benchmarks/requirements.txt

# Create work directory
WORKDIR /workspace

# Copy the repository
COPY . .

# Copy and set permissions for run.sh
COPY run.sh /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh

# Set entrypoint
ENTRYPOINT ["/usr/local/bin/run.sh"]