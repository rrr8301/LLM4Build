FROM eclipse-temurin:8-jdk

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install necessary packages
RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    wget \
    unzip \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Install Gradle
RUN wget https://services.gradle.org/distributions/gradle-7.2-bin.zip && \
    unzip gradle-7.2-bin.zip -d /opt && \
    ln -s /opt/gradle-7.2/bin/gradle /usr/bin/gradle && \
    rm gradle-7.2-bin.zip

# Install Android SDK
ENV ANDROID_SDK_ROOT=/opt/android-sdk
RUN mkdir -p $ANDROID_SDK_ROOT && \
    cd $ANDROID_SDK_ROOT && \
    wget https://dl.google.com/android/repository/commandlinetools-linux-7583922_latest.zip && \
    unzip commandlinetools-linux-7583922_latest.zip && \
    rm commandlinetools-linux-7583922_latest.zip && \
    mkdir -p ~/.android && echo '### User Sources for Android SDK Manager' > ~/.android/repositories.cfg && \
    yes | $ANDROID_SDK_ROOT/cmdline-tools/bin/sdkmanager --sdk_root=$ANDROID_SDK_ROOT "platform-tools" "platforms;android-30"

# Create work directory
WORKDIR /app

# Copy repository
COPY . .

# Ensure gradlew is executable
RUN chmod +x ./gradlew

# Copy run.sh and make it executable
COPY run.sh /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh

# Set entrypoint
ENTRYPOINT ["/usr/local/bin/run.sh"]