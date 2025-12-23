FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install system dependencies
RUN apt-get update && apt-get install -y \
    wget \
    python3 \
    python3-dev \
    python3-pip \
    git \
    && apt-get clean

# Install micromamba
RUN wget -qO- https://micromamba.snakepit.net/api/micromamba/linux-64/latest | tar -xvj -C /usr/local/bin/ --strip-components=1 bin/micromamba

# Create work directory
WORKDIR /app

# Copy repository files
COPY . .

# Install conda dependencies
RUN micromamba create -n pmg -c conda-forge \
    bader enumlib packmol pygraphviz tblite --yes

# Install Python packages
RUN micromamba run -n pmg pip install \
    dgl -f https://data.dgl.ai/wheels/torch-2.4/repo.html \
    matgl>=1.2.6 \
    torch==2.2.0 \
    torchdata==0.7.1

# Copy run.sh and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set entrypoint
ENTRYPOINT ["/app/run.sh"]