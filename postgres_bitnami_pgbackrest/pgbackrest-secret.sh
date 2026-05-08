#!/bin/bash

# It is a wrapper
# 在執行 pgbackrest 指令之前，先從 Docker Secrets 中讀取敏感資料並自動注入環境變數。

set -euo pipefail

if [ -f /run/secrets/pgbackrest_cipher ]; then
    # 它會讀取內容並設定為 pgbackrest 要求的變數。這用於加密備份檔案
    export PGBACKREST_REPO1_CIPHER_PASS
    PGBACKREST_REPO1_CIPHER_PASS="$(cat /run/secrets/pgbackrest_cipher)"
    export PGBACKREST_REPO1_CIPHER_TYPE=aes-256-cbc
fi

if [ -f /run/secrets/db_password ]; then
    export PGPASSWORD
    PGPASSWORD="$(cat /run/secrets/db_password)"
else
    # if no file, show the info
    echo "Warning: /run/secrets/db_password not found. PGPASSWORD will not be set, and pgbackrest may fail to connect to the database if authentication is required."
fi

# 確保 pgbackrest 的日誌目錄存在，並且具有適當的權限。這是因為 pgbackrest 需要寫入日誌文件，如果目錄不存在或權限不足，可能會導致錯誤。
mkdir -p /var/lib/pgbackrest/log

exec pgbackrest "$@"
