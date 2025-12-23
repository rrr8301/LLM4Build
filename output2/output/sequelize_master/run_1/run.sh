#!/bin/bash

# Run all tests, ensuring all test cases are executed
set -e
set -o pipefail

# Run tests
yarn test:format || true
yarn test-unit-esm || true
yarn lerna run test-unit --scope=@sequelize/validator.js || true
yarn lerna run test-unit --scope=@sequelize/cli || true
yarn lerna run test-unit --scope=@sequelize/utils || true
yarn lerna run test-unit-mariadb --scope=@sequelize/core || true
yarn lerna run test-unit --scope=@sequelize/mariadb || true
yarn lerna run test-unit-mysql --scope=@sequelize/core || true
yarn lerna run test-unit --scope=@sequelize/mysql || true
yarn lerna run test-unit-postgres --scope=@sequelize/core || true
yarn lerna run test-unit --scope=@sequelize/postgres || true
yarn lerna run test-unit-sqlite3 --scope=@sequelize/core || true
yarn lerna run test-unit-mssql --scope=@sequelize/core || true
yarn lerna run test-unit --scope=@sequelize/mssql || true
yarn lerna run test-unit-db2 --scope=@sequelize/core || true
yarn lerna run test-unit-ibmi --scope=@sequelize/core || true
yarn lerna run test-unit-snowflake --scope=@sequelize/core || true
yarn sscce-sqlite3 || true
yarn lerna run test-integration --scope=@sequelize/core || true