FROM registry.opensuse.org/home/mia/images/images/mpv-ci:stable-deps

# Set timezone to Pacific Time
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install necessary packages (including lld linker)
RUN zypper install -y meson ninja gcc gcc-c++ lld jq

# Create work directory
WORKDIR /app

# Copy repository contents and set execute permissions
COPY . .
RUN find /app/ci -type f -name "*.sh" -exec chmod +x {} \;

# Configure installation paths explicitly
ENV DESTDIR=/usr/local
RUN mkdir -p ${DESTDIR}/share/man/man1 \
    && mkdir -p ${DESTDIR}/share/applications \
    && mkdir -p ${DESTDIR}/share/doc/mpv \
    && mkdir -p ${DESTDIR}/share/icons/hicolor/{16x16,32x32,64x64,128x128,scalable,symbolic}/apps

# Build the project using Meson with explicit prefix and installation paths
RUN meson setup build \
    --prefix=/usr \
    --libdir=lib \
    --bindir=bin \
    --sbindir=bin \
    --includedir=include \
    --datadir=share \
    --mandir=share/man \
    --infodir=share/info \
    --sysconfdir=etc \
    --localstatedir=var \
    -Db_ndebug=true \
    -Dtests=true

# Build the project
RUN meson compile -C build

# Install the project
RUN DESTDIR=${DESTDIR} meson install -C build