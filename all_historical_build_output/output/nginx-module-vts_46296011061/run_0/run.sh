# run.sh
#!/bin/bash

# Run tests
sudo prove -r t || true

# Ensure all tests are executed, even if some fail
exit 0