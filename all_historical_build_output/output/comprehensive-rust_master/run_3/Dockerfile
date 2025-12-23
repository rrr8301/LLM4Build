FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install dependencies
RUN apt-get update && apt-get install -y \
    curl \
    texlive \
    texlive-luatex \
    texlive-lang-cjk \
    texlive-lang-arabic \
    librsvg2-bin \
    fonts-noto \
    build-essential \
    pkg-config \
    libssl-dev \
    && rm -rf /var/lib/apt/lists/*

# Install Rust
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
ENV PATH="/root/.cargo/bin:${PATH}"

# Create work directory
WORKDIR /app

# Copy repository
COPY . .

# Install pandoc
RUN curl -LsSf https://github.com/jgm/pandoc/releases/download/3.7.0.1/pandoc-3.7.0.1-linux-amd64.tar.gz | tar zxf - -C /usr/local/bin --strip-components=1

# Copy run.sh and make it executable
COPY run.sh /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh

# Set entrypoint
ENTRYPOINT ["/usr/local/bin/run.sh"]