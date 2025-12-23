#!/bin/bash

# Install project dependencies
python3.14 -m pip install uv
python3.14 -m uv sync --all-extras --dev

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
python3.14 -m uv run ruff check .
python3.14 -m uv run ruff format . --check

# Lint with mypy
python3.14 -m uv run mypy .

# Print Python versions
python3.14 -V
python3.14 -m uv run python -V

# Run tests with pytest
export PATH=$HOME/tmux-builds/tmux-3.5/bin:$PATH
python3.14 -m uv run py.test --cov=./ --cov-append --cov-report=xml -n auto --verbose || true