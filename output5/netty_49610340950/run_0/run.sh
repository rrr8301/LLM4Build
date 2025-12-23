#!/bin/bash

set -e
set -o pipefail

# Activate any necessary environments (none specified)

# Build the Docker image using docker-compose
docker-compose -f docker/docker-compose.yaml -f docker/docker-compose.centos-7.111.yaml build

# Run the build and capture output
docker-compose -f docker/docker-compose.yaml -f docker/docker-compose.centos-7.111.yaml run build | tee build.output

# Check for test failures
./.github/scripts/check_build_result.sh build.output || true

# Print JVM thread dumps if cancelled (simulated)
if [ "$CANCELLED" == "true" ]; then
  if [[ "$OSTYPE" == "linux-gnu"* ]] && command -v sudo &> /dev/null; then
    curl -s -L -o /tmp/jattach https://github.com/apangin/jattach/releases/download/v2.1/jattach
    chmod +x /tmp/jattach
    for java_pid in $(sudo pgrep java); do
      echo "----------------------- pid $java_pid -----------------------"
      echo "command line: $(sudo cat /proc/$java_pid/cmdline | xargs -0 echo)"
      sudo /tmp/jattach $java_pid jcmd VM.command_line || true
      sudo /tmp/jattach $java_pid jcmd "Thread.print -l"
      sudo /tmp/jattach $java_pid jcmd GC.heap_info || true
    done
  else
    for java_pid in $(jps -q -J-XX:+PerfDisableSharedMem); do
      echo "----------------------- pid $java_pid -----------------------"
      jcmd $java_pid VM.command_line || true
      jcmd $java_pid Thread.print -l
      jcmd $java_pid GC.heap_info || true
    done
  fi
fi

exit 0