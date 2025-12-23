#!/bin/bash

# Activate Go environment
export PATH="/usr/local/go/bin:${PATH}"

# Get the version
if [[ $GITHUB_REF == refs/tags/* ]]; then
  VERSION=${GITHUB_REF/refs\/tags\//}
else
  VERSION="dev-$(date +'%Y%m%d-%H%M%S')-${GITHUB_SHA::8}"
fi
echo "Tag version: $VERSION"

# Run test suite
go version
cd .ci
./ci-test.sh || true
cd -

# Build all
.ci/ci-build.sh "$VERSION" || true

# Package
.ci/ci-package.sh "$VERSION" || true

# Install minisign and sign if it's a tag
if [[ $GITHUB_REF == refs/tags/* ]]; then
  git clone --depth 1 https://github.com/jedisct1/minisign.git
  cd minisign/src
  mkdir -p /tmp/bin
  cc -O2 -o /tmp/bin/minisign -D_GNU_SOURCE *.c -lsodium
  cd -
  /tmp/bin/minisign -v
  echo '#' > /tmp/minisign.key
  echo "${MINISIGN_SK}" >> /tmp/minisign.key
  cd dnscrypt-proxy
  echo | /tmp/bin/minisign -s /tmp/minisign.key -Sm *.tar.gz *.zip
  ls -l dnscrypt-proxy*
fi