#!/bin/bash

# Clone the repository (if not already present)
if [ ! -d "mvfst" ]; then
    git clone https://github.com/facebook/mvfst.git
fi

cd mvfst

# Update system package info
apt-get update

# Install system dependencies using getdeps.py
python3 build/fbcode_builder/getdeps.py --allow-system-packages install-system-deps --recursive mvfst
python3 build/fbcode_builder/getdeps.py --allow-system-packages install-system-deps --recursive patchelf

# Build mvfst
python3 build/fbcode_builder/getdeps.py --allow-system-packages build --src-dir=. mvfst --project-install-prefix mvfst:/usr/local

# Copy artifacts
python3 build/fbcode_builder/getdeps.py --allow-system-packages fixup-dyn-deps --strip --src-dir=. mvfst _artifacts/linux --project-install-prefix mvfst:/usr/local --final-install-prefix /usr/local

# Test mvfst
python3 build/fbcode_builder/getdeps.py --allow-system-packages test --src-dir=. mvfst --project-install-prefix mvfst:/usr/local || true