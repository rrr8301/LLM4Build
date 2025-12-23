FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install dependencies for pyenv and Python build
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    make build-essential libssl-dev zlib1g-dev \
    libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm \
    libncurses5-dev libncursesw5-dev xz-utils tk-dev libffi-dev \
    liblzma-dev python3-openssl git ca-certificates && \
    apt-get clean

# Install pyenv
RUN curl https://pyenv.run | bash

# Set environment variables for pyenv
ENV PATH="/root/.pyenv/bin:/root/.pyenv/shims:${PATH}"
RUN echo 'eval "$(pyenv init --path)"' >> ~/.bashrc && \
    echo 'eval "$(pyenv init -)"' >> ~/.bashrc

# Install Python 3.13 using pyenv
RUN /bin/bash -c "source ~/.bashrc && pyenv install 3.13-dev && pyenv global 3.13-dev"

# Create work directory
WORKDIR /app

# Copy repository contents
COPY . .

# Install Python dependencies
RUN /bin/bash -c "source ~/.bashrc && python -m pip install --upgrade pip && python -m pip install -r requirements.txt"

# Copy run.sh and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set entrypoint
ENTRYPOINT ["/app/run.sh"]