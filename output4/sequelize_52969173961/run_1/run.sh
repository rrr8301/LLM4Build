#!/bin/bash

# Activate environment (if any specific activation is needed, e.g., nvm, conda, etc.)

# Install project dependencies
yarn install

# Run tests, ensuring all tests are executed even if some fail
set +e
yarn test-unit-esm
yarn lerna run test-unit --scope=@sequelize/validator.js
yarn lerna run test-unit --scope=@sequelize/cli
yarn lerna run test-unit --scope=@sequelize/utils
yarn lerna run test-unit-mariadb --scope=@sequelize/core
yarn lerna run test-unit --scope=@sequelize/mariadb
yarn lerna run test-unit-mysql --scope=@sequelize/core
yarn lerna run test-unit --scope=@sequelize/mysql
yarn lerna run test-unit-postgres --scope=@sequelize/core
yarn lerna run test-unit --scope=@sequelize/postgres
yarn lerna run test-unit-sqlite3 --scope=@sequelize/core
yarn lerna run test-unit-mssql --scope=@sequelize/core
yarn lerna run test-unit --scope=@sequelize/mssql
yarn lerna run test-unit-db2 --scope=@sequelize/core
yarn lerna run test-unit-ibmi --scope=@sequelize/core
yarn lerna run test-unit-snowflake --scope=@sequelize/core
yarn sscce-sqlite3
set -e