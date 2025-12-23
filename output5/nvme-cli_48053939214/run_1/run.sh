#!/bin/bash
set -e
set -x

# Check if the /nvme-cli directory is empty
if [ -z "$(ls -A /nvme-cli)" ]; then
    # Clone the repository if the directory is empty
    git clone https://github.com/linux-nvme/nvme-cli /nvme-cli
fi

cd /nvme-cli

# Build the project
scripts/build.sh -b release -c gcc

# Create config.json
CONTROLLER=$(echo "${BDEV0}" | sed 's/n[0-9]*$//')
cat > tests/config.json << EOJ
{
  "controller" : "${CONTROLLER}",
  "ns1": "${BDEV0}",
  "log_dir": "tests/nvmetests/",
  "nvme_bin": "/nvme-cli/.build-ci/nvme"
}
EOJ

# Run tests
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
nvme_writezeros_test || true