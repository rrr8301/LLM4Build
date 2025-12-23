FROM eclipse-temurin:21-jdk

# Install Maven
ARG MAVEN_VERSION=3.9.3
ARG USER_HOME_DIR="/root"
ARG BASE_URL=https://archive.apache.org/dist/maven/maven-3/${MAVEN_VERSION}/binaries
ARG SHA=sha512sum_placeholder

RUN apt-get update && apt-get install -y curl tar && \
    curl -fsSL ${BASE_URL}/apache-maven-${MAVEN_VERSION}-bin.tar.gz -o /tmp/apache-maven.tar.gz && \
    # (Optional) verify checksum here if desired \
    tar -xzf /tmp/apache-maven.tar.gz -C /opt && \
    ln -s /opt/apache-maven-${MAVEN_VERSION} /opt/maven && \
    rm /tmp/apache-maven.tar.gz && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

ENV MAVEN_HOME=/opt/maven
ENV PATH=${MAVEN_HOME}/bin:${PATH}

# Create workspace directory
WORKDIR /workspace

# Copy the repository files
COPY . /workspace

# Copy run.sh and make executable
COPY run.sh /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh

ENTRYPOINT ["/usr/local/bin/run.sh"]