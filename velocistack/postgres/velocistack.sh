#!/usr/bin/env bash

set -e

# Creat a Postgres administrator account
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" \
  -c "CREATE USER ${POSTGRES_ADMIN_USER} WITH CREATEDB SUPERUSER PASSWORD '${POSTGRES_ADMIN_PASSWORD}';"

# Create a database for Intel Owl
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" \
  -c "CREATE DATABASE ${POSTGRES_DB_INTELOWL};" \
  -c "GRANT ALL PRIVILEGES ON DATABASE ${POSTGRES_DB_INTELOWL} TO ${POSTGRES_USER};"

# Create a database for IRIS
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" \
  -c "CREATE DATABASE ${POSTGRES_DB_IRIS};" \
  -c "CREATE DATABASE ${POSTGRES_DB_IRIS_TASKS};" \
  -c "GRANT ALL PRIVILEGES ON DATABASE ${POSTGRES_DB_IRIS} TO ${POSTGRES_USER};"