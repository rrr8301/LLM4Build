FROM ubuntu:latest

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install OS-level dependencies
RUN apt-get update && apt-get install -y \
    libhdf5-dev \
    curl \
    build-essential \
    libssl-dev \
    zlib1g-dev \
    libbz2-dev \
    libreadline-dev \
    libsqlite3-dev \
    wget \
    llvm \
    libncurses5-dev \
    libncursesw5-dev \
    xz-utils \
    tk-dev \
    libffi-dev \
    liblzma-dev \
    python3-pip

# Install pyenv
RUN curl https://pyenv.run | bash

# Set environment variables for pyenv
ENV PATH="/root/.pyenv/bin:/root/.pyenv/shims:${PATH}"
RUN echo 'eval "$(pyenv init --path)"' >> ~/.bashrc

# Install Python 3.14 (pre-release)
RUN pyenv install 3.14-dev && pyenv global 3.14-dev

# Create a working directory
WORKDIR /app

# Copy the repository into the container
COPY . .

# Install Python dependencies using uv
RUN pip install uv

# Copy run.sh and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set the entrypoint
ENTRYPOINT ["/app/run.sh"]