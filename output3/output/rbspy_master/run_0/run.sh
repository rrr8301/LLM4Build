#!/bin/bash

set -euxo pipefail

# Activate Ruby environment
source /usr/local/rvm/scripts/rvm

# Install Ruby dependencies
bundle install

# Clean previous builds
sudo rm -rf ~/.bundle
chronic sudo git clean -fdx

# Build and Test
chronic ./autogen.sh
chronic ./configure --disable-install-doc
chronic make || exit 125
chronic sudo make install || exit 125

# Display Ruby version
echo "Ruby version: $(/usr/local/bin/ruby -v)"

# Run the test script
/usr/local/bin/ruby ci/ruby-programs/infinite_on_cpu.rb &
sudo ./target/release/rbspy record --pid $! --duration 2 --force-version $RUBY_VERSION --silent