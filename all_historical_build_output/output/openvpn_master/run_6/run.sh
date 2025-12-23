#!/bin/bash

# Enable TUN device
if [ ! -c /dev/net/tun ]; then
    mkdir -p /dev/net
    mknod /dev/net/tun c 10 200
    chmod 600 /dev/net/tun
fi

# Configure checks
echo 'RUN_SUDO="sudo -E"' > tests/t_server_null.rc

# Run tests
set +e  # Continue on error
make -j3 check VERBOSE=1