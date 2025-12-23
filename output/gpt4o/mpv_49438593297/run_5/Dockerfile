FROM registry.opensuse.org/home/mia/images/images/mpv-ci:stable-deps

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install necessary packages (including lld linker)
RUN zypper install -y meson ninja gcc gcc-c++ lld

# Create work directory
WORKDIR /app

# Copy repository contents and set execute permissions
COPY . .
RUN find /app/ci -type f -name "*.sh" -exec chmod +x {} \;

# Copy run.sh and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set entrypoint
ENTRYPOINT ["/app/run.sh"]