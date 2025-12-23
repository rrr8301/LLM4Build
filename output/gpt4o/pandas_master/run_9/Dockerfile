# Dockerfile
FROM ubuntu:24.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install Python 3.12, pip, build tools and git
RUN apt-get update && \
    apt-get install -y python3.12 python3-pip python3.12-venv tzdata \
    build-essential cython3 python3.12-dev git ninja-build meson && \
    apt-get clean

# Set work directory
WORKDIR /app

# Create and activate virtual environment
RUN python3.12 -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

# First copy only requirements files to leverage Docker cache
COPY requirements*.txt ./
COPY pyproject.toml ./

# Install Python dependencies with specific setuptools version
RUN pip install --upgrade pip && \
    pip install "setuptools<81" && \
    pip install -r requirements.txt || \
    pip install -r requirements-dev.txt || \
    pip install .

# Install Cython first to ensure proper compilation
RUN pip install cython==3.0.8

# Install pandas from source with specific version to avoid meson issues
RUN git clone https://github.com/pandas-dev/pandas.git && \
    cd pandas && \
    git checkout tags/v2.2.0 && \
    pip install -e . --no-build-isolation && \
    cd ..

# Copy the rest of the repository
COPY . .

# Build the project before running tests
RUN python3.12 setup.py build_ext --inplace || echo "Build extension step failed, continuing with tests"

# Install pytest and plugins
RUN pip install pytest pytest-cython pytest-xdist

# Copy run.sh and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set entrypoint
ENTRYPOINT ["/app/run.sh"]