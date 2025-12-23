FROM ubuntu:22.04

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install dependencies
RUN apt-get update -qq && \
    apt-get install --assume-yes --no-install-recommends \
    ccache \
    gettext autopoint \
    libtool \
    libgtk-3-dev \
    doxygen \
    python3-docutils \
    python3-lxml \
    rst2pdf \
    make \
    gcc \
    g++ \
    git

# Create work directory
WORKDIR /app

# Copy repository
COPY . .

# Copy run.sh and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set entrypoint
ENTRYPOINT ["/app/run.sh"]