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
RUN curl -sL https://downloads.apache.org/maven/maven-3/3.8.6/binaries/apache-maven-3.8.6-bin.zip -o maven.zip \
    && unzip maven.zip -d /opt \
    && rm maven.zip \
    && ln -s /opt/apache-maven-3.8.6/bin/mvn /usr/bin/mvn

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