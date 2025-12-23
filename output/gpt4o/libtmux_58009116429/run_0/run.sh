#!/bin/bash

# Activate Python environment
source /usr/bin/python3.14

# Install project dependencies
uv sync --all-extras --dev

# Build tmux if not cached
if [ ! -d "$HOME/tmux-builds/tmux-3.5" ]; then
    mkdir -p ~/tmux-builds ~/tmux-src
    git clone https://github.com/tmux/tmux.git ~/tmux-src/tmux-3.5
    cd ~/tmux-src/tmux-3.5
    git checkout 3.5
    sh autogen.sh
    ./configure --prefix=$HOME/tmux-builds/tmux-3.5 && make && make install
    export PATH=$HOME/tmux-builds/tmux-3.5/bin:$PATH
    cd ~
fi

# Lint and format with ruff
uv run ruff check .
uv run ruff format . --check

# Lint with mypy
uv run mypy .

# Print Python versions
python -V
uv run python -V

# Run tests with pytest
export PATH=$HOME/tmux-builds/tmux-3.5/bin:$PATH
uv run py.test --cov=./ --cov-append --cov-report=xml -n auto --verbose || true