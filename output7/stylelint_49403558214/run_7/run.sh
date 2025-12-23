#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Run tests
npm test || {
    echo "Tests failed. Attempting to fix ESLint configuration for ES Modules."
    
    # Attempt to fix ESLint configuration for ES Modules
    if [ -f .eslintrc.js ]; then
        # Convert CommonJS to ES Module syntax if necessary
        sed -i 's/module.exports = {/export default {/g' .eslintrc.js
    fi

    # Check if the ESLint configuration file is using CommonJS and convert it to ESM
    if grep -q "require(" .eslintrc.js; then
        sed -i 's/require(/import(/g' .eslintrc.js
        sed -i 's/module.exports = {/export default {/g' .eslintrc.js
    fi

    # Re-run tests
    npm test
}