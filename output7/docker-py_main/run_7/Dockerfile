# No changes needed in the Dockerfile
FROM ubuntu:22.04

ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update && apt-get install -y \
    python3 \
    python3-venv \
    python3-pip \
    make \
    git \
    curl \
    && apt-get clean

RUN curl -fsSL https://get.docker.com | sh

WORKDIR /app

COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

ENTRYPOINT ["/app/run.sh"]