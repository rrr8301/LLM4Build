#!/bin/bash

# Run tests without using sudo
prove -r t

# Exit with the status of the last command
exit $?