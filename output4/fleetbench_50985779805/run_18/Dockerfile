FROM ubuntu:latest

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install dependencies
RUN apt-get update && apt-get install -y \
    clang \
    llvm \
    lld \
    git \
    python3.12 \
    python3-pip \
    curl \
    gnupg \
    apt-transport-https \
    openjdk-11-jdk  # Ensure Java is installed for Bazel

# Add Bazel distribution URI as a package source and install Bazel 8.0.0
RUN curl -fsSL https://bazel.build/bazel-release.pub.gpg | gpg --dearmor > /usr/share/keyrings/bazel-archive-keyring.gpg \
    && echo "deb [signed-by=/usr/share/keyrings/bazel-archive-keyring.gpg] https://storage.googleapis.com/bazel-apt stable jdk1.8" | tee /etc/apt/sources.list.d/bazel.list \
    && apt-get update \
    && apt-get install -y bazel-8.0.0

# Ensure Bazel is in the PATH
ENV PATH="/usr/local/bin:/usr/bin:/bin:/bazel-bin:/usr/local/bazel/bin:$PATH"

# Create work directory
WORKDIR /app

# Copy repository
COPY . .

# Copy run.sh and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set entrypoint
ENTRYPOINT ["/app/run.sh"]