# Use Ubuntu 22.04 as the base image
FROM ubuntu:22.04

# Set the timezone to Pacific Time (America/Los_Angeles)
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install necessary packages
RUN apt-get update && apt-get install -y \
    git \
    curl \
    unzip \
    tzdata \
    && rm -rf /var/lib/apt/lists/*

# Install Maven
ENV MAVEN_VERSION=3.8.6
ENV MAVEN_SHA=7b1d1e8e1b1e1b1e1b1e1b1e1b1e1b1e1b1e1b1e1b1e1b1e1b1e1b1e1b1e1b1
RUN curl -sL https://downloads.apache.org/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.zip -o maven.zip \
    && echo "$MAVEN_SHA  maven.zip" | sha256sum -c - \
    && unzip maven.zip -d /opt \
    && rm maven.zip \
    && ln -s /opt/apache-maven-$MAVEN_VERSION/bin/mvn /usr/bin/mvn

# Install OpenJDK 21
RUN apt-get update && apt-get install -y openjdk-21-jdk && rm -rf /var/lib/apt/lists/*

# Set JAVA_HOME environment variable
ENV JAVA_HOME=/usr/lib/jvm/java-21-openjdk-amd64
ENV PATH="$JAVA_HOME/bin:$PATH"

# Create a work directory
WORKDIR /app

# Copy the repository contents into the container
COPY . .

# Copy the run.sh script and make it executable
COPY run.sh /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh

# Set the entrypoint to run.sh
ENTRYPOINT ["/usr/local/bin/run.sh"]