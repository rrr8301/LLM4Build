#!/bin/bash

set -e

# Function to run commands with retry logic
run_with_retry() {
    local cmd="$1"
    local time_out=10
    local retries=10
    local attempt=0

    for ((i=1; i<=retries; i++)); do
        attempt=$((i))
        if timeout -s 12 --preserve-status $time_out $cmd; then
            echo "Command succeeded on attempt $i."
            return 0
        else
            local exit_code=$?
            if [ $exit_code -eq 140 ]; then
                echo "Attempt $i timed out (retrying...)"
                time_out=$((time_out + 5))
            else
                echo "Attempt $i failed with exit code $exit_code. Aborting workflow."
                exit $exit_code
            fi
        fi
    done
    echo "All $retries attempts failed, giving up."
    echo "Final failure was due to timeout."
    echo "Aborting workflow."
    exit $exit_code
}

# Build QEMU
git clone https://github.com/qemu/qemu.git
cd qemu
git checkout 222729c7455784dd855216d7a2bec4bd8f2a6800
patch -p1 < ../222729c7455784dd855216d7a2bec4bd8f2a6800.patch
export CXXFLAGS="-Wno-error"; export CFLAGS="-Wno-error"
./configure --prefix=/workspace/qemu-install --target-list=riscv64-linux-user --disable-system
make -j$(nproc)
make install
cd ..

# Build OpenBLAS
wget ${xuetie_toolchain}/${toolchain_file_name}
tar -xvf ${toolchain_file_name} -C /opt
export PATH="/opt/Xuantie-900-gcc-linux-5.10.4-glibc-x86_64-V2.8.0/bin:$PATH"

make CC='ccache riscv64-unknown-linux-gnu-gcc -static' FC='ccache riscv64-unknown-linux-gnu-gfortran -static' NO_SHARED=1 TARGET=C910V HOSTCC='ccache gcc' -j$(nproc)

# Run tests
export PATH=/workspace/qemu-install/bin:$PATH
which qemu-riscv64
export QEMU_BIN=$(which qemu-riscv64)
run_with_retry "$QEMU_BIN ./utest/openblas_utest"
run_with_retry "$QEMU_BIN ./utest/openblas_utest_ext"

OPENBLAS_NUM_THREADS=2 qemu-riscv64 ./ctest/xscblat1
OPENBLAS_NUM_THREADS=2 qemu-riscv64 ./ctest/xdcblat1
OPENBLAS_NUM_THREADS=2 qemu-riscv64 ./ctest/xccblat1
OPENBLAS_NUM_THREADS=2 qemu-riscv64 ./ctest/xzcblat1
OPENBLAS_NUM_THREADS=2 qemu-riscv64 ./ctest/xscblat2 < ./ctest/sin2
OPENBLAS_NUM_THREADS=2 qemu-riscv64 ./ctest/xdcblat2 < ./ctest/din2
OPENBLAS_NUM_THREADS=2 qemu-riscv64 ./ctest/xccblat2 < ./ctest/cin2
OPENBLAS_NUM_THREADS=2 qemu-riscv64 ./ctest/xzcblat2 < ./ctest/zin2
OPENBLAS_NUM_THREADS=2 qemu-riscv64 ./ctest/xscblat3 < ./ctest/sin3
OPENBLAS_NUM_THREADS=2 qemu-riscv64 ./ctest/xdcblat3 < ./ctest/din3
OPENBLAS_NUM_THREADS=2 qemu-riscv64 ./ctest/xccblat3 < ./ctest/cin3
OPENBLAS_NUM_THREADS=2 qemu-riscv64 ./ctest/xzcblat3 < ./ctest/zin3
OPENBLAS_NUM_THREADS=1 OMP_NUM_THREADS=1 qemu-riscv64 ./test/sblat1
OPENBLAS_NUM_THREADS=1 OMP_NUM_THREADS=1 qemu-riscv64 ./test/dblat1
OPENBLAS_NUM_THREADS=1 OMP_NUM_THREADS=1 qemu-riscv64 ./test/cblat1
OPENBLAS_NUM_THREADS=1 OMP_NUM_THREADS=1 qemu-riscv64 ./test/zblat1
OPENBLAS_NUM_THREADS=2 qemu-riscv64 ./test/sblat1
OPENBLAS_NUM_THREADS=2 qemu-riscv64 ./test/dblat1
OPENBLAS_NUM_THREADS=2 qemu-riscv64 ./test/cblat1
OPENBLAS_NUM_THREADS=2 qemu-riscv64 ./test/zblat1
rm -f ./test/?BLAT2.SUMM
OPENBLAS_NUM_THREADS=1 OMP_NUM_THREADS=1 qemu-riscv64 ./test/sblat2 < ./test/sblat2.dat
OPENBLAS_NUM_THREADS=1 OMP_NUM_THREADS=1 qemu-riscv64 ./test/dblat2 < ./test/dblat2.dat
OPENBLAS_NUM_THREADS=1 OMP_NUM_THREADS=1 qemu-riscv64 ./test/cblat2 < ./test/cblat2.dat
OPENBLAS_NUM_THREADS=1 OMP_NUM_THREADS=1 qemu-riscv64 ./test/zblat2 < ./test/zblat2.dat
rm -f ./test/?BLAT2.SUMM
OPENBLAS_NUM_THREADS=2 qemu-riscv64 ./test/sblat2 < ./test/sblat2.dat
OPENBLAS_NUM_THREADS=2 qemu-riscv64 ./test/dblat2 < ./test/dblat2.dat
OPENBLAS_NUM_THREADS=2 qemu-riscv64 ./test/cblat2 < ./test/cblat2.dat
OPENBLAS_NUM_THREADS=2 qemu-riscv64 ./test/zblat2 < ./test/zblat2.dat
rm -f ./test/?BLAT3.SUMM
OPENBLAS_NUM_THREADS=1 OMP_NUM_THREADS=1 qemu-riscv64 ./test/sblat3 < ./test/sblat3.dat
OPENBLAS_NUM_THREADS=1 OMP_NUM_THREADS=1 qemu-riscv64 ./test/dblat3 < ./test/dblat3.dat
OPENBLAS_NUM_THREADS=1 OMP_NUM_THREADS=1 qemu-riscv64 ./test/cblat3 < ./test/cblat3.dat
OPENBLAS_NUM_THREADS=1 OMP_NUM_THREADS=1 qemu-riscv64 ./test/zblat3 < ./test/zblat3.dat
rm -f ./test/?BLAT3.SUMM
OPENBLAS_NUM_THREADS=2 qemu-riscv64 ./test/sblat3 < ./test/sblat3.dat
OPENBLAS_NUM_THREADS=2 qemu-riscv64 ./test/dblat3 < ./test/dblat3.dat
OPENBLAS_NUM_THREADS=2 qemu-riscv64 ./test/cblat3 < ./test/cblat3.dat
OPENBLAS_NUM_THREADS=2 qemu-riscv64 ./test/zblat3 < ./test/zblat3.dat