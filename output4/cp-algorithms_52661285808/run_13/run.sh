#!/bin/bash

# Activate Python virtual environment
source venv/bin/activate

# Check if extract_snippets.py exists
if [ ! -f "extract_snippets.py" ]; then
    echo "Error: extract_snippets.py not found!"
    exit 1
fi

# Run extract_snippets.py if it exists
python extract_snippets.py

# Run tests
set +e  # Continue execution even if some tests fail
./test/test.sh

# Check for *.cpp files and compile them if they exist
CPP_FILES=$(ls *.cpp 2>/dev/null)
if [ -z "$CPP_FILES" ]; then
    echo "No .cpp files found for compilation."
else
    for file in $CPP_FILES; do
        g++ -o "${file%.cpp}" "$file"
        if [ $? -ne 0 ]; then
            echo "Compilation error on $file!"
            exit 1
        fi
    done
fi