#!/bin/bash
set -eo pipefail

# Inject pgbackrest cipher passphrase from Docker secret into the environment
# so PostgreSQL's archive_command inherits it at runtime.
# pgbackrest does not support _FILE suffix for PGBACKREST_REPO1_CIPHER_PASS.
if [ -f /run/secrets/pgbackrest_cipher ]; then
    export PGBACKREST_REPO1_CIPHER_PASS
    PGBACKREST_REPO1_CIPHER_PASS=$(cat /run/secrets/pgbackrest_cipher)
    export PGBACKREST_REPO1_CIPHER_TYPE=aes-256-cbc
fi

# Delegate to the original bitnami entrypoint (handles all PostgreSQL init)
exec /opt/bitnami/scripts/postgresql/entrypoint.sh "$@"
