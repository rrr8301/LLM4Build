#!/bin/bash

# Set environment variables
export DOTNET_CLI_TELEMETRY_OPTOUT=1
export DOTNET_SKIP_FIRST_TIME_EXPERIENCE=1
export node_version=16.x
export pg_db=marten_testing
export pg_user=postgres
export CONFIGURATION=Release
export FRAMEWORK=net9.0
export DISABLE_TEST_PARALLELIZATION=true
export DEFAULT_SERIALIZER="Newtonsoft"
export NUKE_TELEMETRY_OPTOUT=true

# Install .NET Aspire workload
dotnet workload update
dotnet workload install aspire

# Check and install plv8 extension
PG_CONTAINER_NAME=$(docker ps --filter expose=5432/tcp --format {{.Names}})
docker exec $PG_CONTAINER_NAME psql -U $pg_user -d $pg_db -c "CREATE EXTENSION IF NOT EXISTS plv8;"
docker exec $PG_CONTAINER_NAME psql -U $pg_user -d $pg_db -c "DO 'plv8.elog(NOTICE, plv8.version);' LANGUAGE plv8;"

# Optimize database for running tests faster
docker exec $PG_CONTAINER_NAME bash -c "echo -e '\nfsync = off' >> /var/lib/postgresql/data/postgresql.conf"
docker exec $PG_CONTAINER_NAME bash -c "echo -e '\nfull_page_writes = off' >> /var/lib/postgresql/data/postgresql.conf"
docker exec $PG_CONTAINER_NAME bash -c "echo -e '\nsynchronous_commit = off' >> /var/lib/postgresql/data/postgresql.conf"
docker container restart $PG_CONTAINER_NAME

# Compile the project
./build.sh compile

# Run tests, ensuring all tests are executed
for test in test-base-lib test-core test-document-db test-event-sourcing test-cli test-linq test-patching test-value-types test-code-gen test-noda-time test-aspnet-core test-plv8; do
    ./build.sh $test || true
done