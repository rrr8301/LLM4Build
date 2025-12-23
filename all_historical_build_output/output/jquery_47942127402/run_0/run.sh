# run.sh
#!/bin/bash

# Run npm install to ensure all dependencies are installed
npm install

# Run tests and ensure all tests are executed even if some fail
npm run test:browserless || true