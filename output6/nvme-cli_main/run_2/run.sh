#!/bin/bash

# Activate Python environment (if any virtual environment is used, activate it here)

# Install project dependencies
pip3 install -r requirements.txt

# Build the project
./scripts/build.sh -b release -c gcc

# Run tests
set +e  # Continue on error
nose2 --verbose --start-dir tests \
    nvme_attach_detach_ns_test \
    nvme_compare_test \
    nvme_copy_test \
    nvme_create_max_ns_test \
    nvme_ctrl_reset_test \
    nvme_dsm_test \
    nvme_error_log_test \
    nvme_flush_test \
    nvme_format_test \
    nvme_fw_log_test \
    nvme_get_features_test \
    nvme_get_lba_status_test \
    nvme_id_ctrl_test \
    nvme_id_ns_test \
    nvme_lba_status_log_test \
    nvme_read_write_test \
    nvme_smart_log_test \
    nvme_verify_test \
    nvme_writeuncor_test \
    nvme_writezeros_test

# Ensure all tests are executed
set -e