#!/bin/bash

# Activate .NET environment
export DOTNET_ROOT=$HOME/.dotnet
export PATH=$PATH:$DOTNET_ROOT

# Install project dependencies
dotnet workload update
dotnet workload install aspire

# Optimize PostgreSQL database
PG_CONTAINER_NAME=$(docker ps --filter expose=5432/tcp --format {{.Names}})
docker exec $PG_CONTAINER_NAME bash -c "echo -e '\nfsync = off' >> /var/lib/postgresql/data/postgresql.conf"
docker exec $PG_CONTAINER_NAME bash -c "echo -e '\nfull_page_writes = off' >> /var/lib/postgresql/data/postgresql.conf"
docker exec $PG_CONTAINER_NAME bash -c "echo -e '\nsynchronous_commit = off' >> /var/lib/postgresql/data/postgresql.conf"
docker container restart $PG_CONTAINER_NAME

# Compile the project
./build.sh compile

# Run tests, ensuring all tests are executed
for test in test-base-lib test-core test-document-db test-event-sourcing test-cli test-linq test-patching test-value-types test-code-gen test-noda-time test-aspnet-core; do
    ./build.sh $test || true
done