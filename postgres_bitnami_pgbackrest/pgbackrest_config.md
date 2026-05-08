
# [來源](https://pgbackrest.org/configuration.html#introduction)

|Type|Description|Config|Default|
|---|---|---|---|
|Archive Options|Asynchronous Archiving Option |--archive-async|y|
|Archive Options|Maximum Archive Get Queue Size Option |--archive-get-queue-max|1GiB|
|Archive Options|Retry Missing WAL Segment Option |--archive-missing-retry|n|
|Archive Options|Maximum Archive Push Queue Size Option |--archive-push-queue-max||
|Archive Options|Archive Timeout Option |--archive-timeout|1m|
|Backup Options|Backup Annotation Option |--annotation||
|Backup Options|Check Archive Option |--archive-check|y|
|Backup Options|Copy Archive Option |--archive-copy|y|
|Backup Options|Check Archive Mode Option |--archive-mode-check|n|
|Backup Options|Backup from Standby Option |--backup-standby|n|
|Backup Options|Page Checksums Option |--checksum-page||
|Backup Options|Path/File Exclusions Option |--exclude||
|Backup Options|Expire Auto Option |--expire-auto|y|
|Backup Options|Manifest Save Threshold Option |--manifest-save-threshold|1GiB|
|Backup Options|Resume Option |--resume|y|
|Backup Options|Start Fast Option |--start-fast|n|
|General Options|Buffer Size Option |--buffer-size|1MiB|
|General Options|pgBackRest Command Option |--cmd|[path of executed pgbackrest binary]|
|General Options|SSH Client Command Option |--cmd-ssh|ssh|
|General Options|Compress Option |--compress|y|
|General Options|Compress Level Option |--compress-level||
|General Options|Network Compress Level Option |--compress-level-network|1|
|General Options|Compress Type Option |--compress-type|gz|
|General Options|Database Timeout Option |--db-timeout|30m|
|General Options|Delta Option |--delta|n|
|General Options|I/O Timeout Option |--io-timeout|1m|
|General Options|Lock Path Option |--lock-path|/tmp/pgbackrest|
|General Options|Neutral Umask Option |--neutral-umask|y|
|General Options|Set Process Priority Option |--priority||
|General Options|Process Maximum Option |--process-max|1|
|General Options|Protocol Timeout Option |--protocol-timeout|31m|
|General Options|Keep Alive Option |--sck-keep-alive|y|
|General Options|Spool Path Option |--spool-path|/var/spool/pgbackrest|
|General Options|Keep Alive Count Option |--tcp-keep-alive-count|[1, 32]|
|General Options|Keep Alive Idle Option |--tcp-keep-alive-idle|[1, 3600]|
|General Options|Keep Alive Interval Option |--tcp-keep-alive-interval|[1, 900]|
|General Options|TLSv1.2 cipher suites Option |--tls-cipher-12||
|General Options|TLSv1.3 cipher suites Option |--tls-cipher-13||
|Log Options|Console Log Level Option |--log-level-console|warn|
|Log Options|File Log Level Option |--log-level-file|info|
|Log Options|Std Error Log Level Option |--log-level-stderr|off|
|Log Options|Log Path Option |--log-path|/var/log/pgbackrest|
|Log Options|Log Subprocesses Option |--log-subprocess|n|
|Log Options|Log Timestamp Option |--log-timestamp|y|
|Maintainer Options|Check WAL Headers Option |--archive-header-check|y|
|Maintainer Options|Page Header Check Option |--page-header-check|y|
|Maintainer Options|Force PostgreSQL Version Option |--pg-version-force||
|Repository Options|Azure Repository Account Option |--repo-azure-account||
|Repository Options|Azure Repository Container Option |--repo-azure-container||
|Repository Options|Azure Repository Endpoint Option |--repo-azure-endpoint|blob.core.windows.net|
|Repository Options|Azure Repository Key Option |--repo-azure-key||
|Repository Options|Azure Repository Key Type Option |--repo-azure-key-type|shared|
|Repository Options|Azure Repository URI Style Option |--repo-azure-uri-style|host|
|Repository Options|Block Incremental Backup Option |--repo-block|n|
|Repository Options|Repository Bundles Option |--repo-bundle|n|
|Repository Options|Repository Bundle Limit Option |--repo-bundle-limit|2MiB|
|Repository Options|Repository Bundle Size Option |--repo-bundle-size|20MiB|
|Repository Options|Repository Cipher Passphrase Option |--repo-cipher-pass||
|Repository Options|Repository Cipher Type Option |--repo-cipher-type|none|
|Repository Options|GCS Repository Bucket Option |--repo-gcs-bucket||
|Repository Options|GCS Repository Endpoint Option |--repo-gcs-endpoint|storage.googleapis.com|
|Repository Options|GCS Repository Key Option |--repo-gcs-key||
|Repository Options|GCS Repository Key Type Option |--repo-gcs-key-type|service|
|Repository Options|GCS Repository Project ID Option |--repo-gcs-user-project||
|Repository Options|Repository Hardlink Option |--repo-hardlink|n|
|Repository Options|Repository Host Option |--repo-host||
|Repository Options|Repository Host Certificate Authority File Option |--repo-host-ca-file||
|Repository Options|Repository Host Certificate Authority Path Option |--repo-host-ca-path||
|Repository Options|Repository Host Certificate File Option |--repo-host-cert-file||
|Repository Options|Repository Host Command Option |--repo-host-cmd|[path of executed pgbackrest binary]|
|Repository Options|Repository Host Configuration Option |--repo-host-config|CFGOPTDEF_CONFIG_PATH "/" PROJECT_CONFIG_FILE|
|Repository Options|Repository Host Configuration Include Path Option |--repo-host-config-include-path|CFGOPTDEF_CONFIG_PATH "/" PROJECT_CONFIG_INCLUDE_PATH|
|Repository Options|Repository Host Configuration Path Option |--repo-host-config-path|CFGOPTDEF_CONFIG_PATH|
|Repository Options|Repository Host Key File Option |--repo-host-key-file||
|Repository Options|Repository Host Port Option |--repo-host-port||
|Repository Options|Repository Host Protocol Type Option |--repo-host-type|ssh|
|Repository Options|Repository Host User Option |--repo-host-user|pgbackrest|
|Repository Options|Repository Path Option |--repo-path|/var/lib/pgbackrest|
|Repository Options|Archive Retention Option |--repo-retention-archive|[1, 9999999]|
|Repository Options|Archive Retention Type Option |--repo-retention-archive-type|full|
|Repository Options|Differential Retention Option |--repo-retention-diff|[1, 9999999]|
|Repository Options|Full Retention Option |--repo-retention-full|[1, 9999999]|
|Repository Options|Full Retention Type Option |--repo-retention-full-type|count|
|Repository Options|Backup History Retention Option |--repo-retention-history|[0, 9999999]|
|Repository Options|S3 Repository Bucket Option |--repo-s3-bucket||
|Repository Options|S3 Repository Endpoint Option |--repo-s3-endpoint||
|Repository Options|S3 Repository Access Key Option |--repo-s3-key||
|Repository Options|S3 Repository Secret Access Key Option |--repo-s3-key-secret||
|Repository Options|S3 Repository Key Type Option |--repo-s3-key-type|shared|
|Repository Options|S3 Repository KMS Key ID Option |--repo-s3-kms-key-id||
|Repository Options|S3 Repository Region Option |--repo-s3-region||
|Repository Options|S3 Repository Requestor Pays Option |--repo-s3-requester-pays|n|
|Repository Options|S3 Repository Role Option |--repo-s3-role||
|Repository Options|S3 Repository SSE Customer Key Option |--repo-s3-sse-customer-key||
|Repository Options|S3 Repository Security Token Option |--repo-s3-token||
|Repository Options|S3 Repository URI Style Option |--repo-s3-uri-style|host|
|Repository Options|SFTP Repository Host Option |--repo-sftp-host||
|Repository Options|SFTP Repository Host Fingerprint Option |--repo-sftp-host-fingerprint||
|Repository Options|SFTP Host Key Check Type Option |--repo-sftp-host-key-check-type|strict|
|Repository Options|SFTP Repository Host Key Hash Type Option |--repo-sftp-host-key-hash-type||
|Repository Options|SFTP Repository Host Port Option |--repo-sftp-host-port|22|
|Repository Options|SFTP Repository Host User Option |--repo-sftp-host-user||
|Repository Options|SFTP Known Hosts File Option |--repo-sftp-known-host||
|Repository Options|SFTP Repository Private Key File Option |--repo-sftp-private-key-file||
|Repository Options|SFTP Repository Private Key Passphrase Option |--repo-sftp-private-key-passphrase||
|Repository Options|SFTP Repository Public Key File Option |--repo-sftp-public-key-file||
|Repository Options|Repository Storage CA File Option |--repo-storage-ca-file||
|Repository Options|Repository Storage TLS CA Path Option |--repo-storage-ca-path||
|Repository Options|Repository Storage Host Option |--repo-storage-host||
|Repository Options|Repository Storage Port Option |--repo-storage-port|443|
|Repository Options|Repository Storage Tag Option |--repo-storage-tag||
|Repository Options|Repository Storage Upload Chunk Size Option |--repo-storage-upload-chunk-size||
|Repository Options|Repository Storage Certificate Verify Option |--repo-storage-verify-tls|y|
|Repository Options|Repository Symlink Option |--repo-symlink|y|
|Repository Options|Target Time for Repository Option |--repo-target-time||
|Repository Options|Repository Type Option |--repo-type|posix|
|Restore Options|Archive Mode Option |--archive-mode|preserve|
|Restore Options|Exclude Database Option |--db-exclude||
|Restore Options|Include Database Option |--db-include||
|Restore Options|Link All Option |--link-all|n|
|Restore Options|Link Map Option |--link-map||
|Restore Options|Recovery Option Option |--recovery-option||
|Restore Options|Tablespace Map Option |--tablespace-map||
|Restore Options|Map All Tablespaces Option |--tablespace-map-all||
|Server Options|TLS Server Address Option |--tls-server-address|localhost (可以 *)|
|Server Options|TLS Server Authorized Clients Option |--tls-server-auth||
|Server Options|TLS Server Certificate Authorities Option |--tls-server-ca-file||
|Server Options|TLS Server Certificate Option |--tls-server-cert-file||
|Server Options|TLS Server Key Option |--tls-server-key-file||
|Server Options|TLS Server Port Option |--tls-server-port|8432 [1, 65535]|
|Stanza Options|PostgreSQL Database Option |--pg-database|postgres|
|Stanza Options|PostgreSQL Host Option |--pg-host||
|Stanza Options|PostgreSQL Host Certificate Authority File Option |--pg-host-ca-file||
|Stanza Options|PostgreSQL Host Certificate Authority Path Option |--pg-host-ca-path||
|Stanza Options|PostgreSQL Host Certificate File Option |--pg-host-cert-file||
|Stanza Options|PostgreSQL Host Command Option |--pg-host-cmd|[path of executed pgbackrest binary]|
|Stanza Options|PostgreSQL Host Configuration Option |--pg-host-config|CFGOPTDEF_CONFIG_PATH "/" PROJECT_CONFIG_FILE|
|Stanza Options|PostgreSQL Host Configuration Include Path Option |--pg-host-config-include-path|CFGOPTDEF_CONFIG_PATH "/" PROJECT_CONFIG_INCLUDE_PATH|
|Stanza Options|PostgreSQL Host Configuration Path Option |--pg-host-config-path|CFGOPTDEF_CONFIG_PATH|
|Stanza Options|PostgreSQL Host Key File Option |--pg-host-key-file||
|Stanza Options|PostgreSQL Host Port Option |--pg-host-port||
|Stanza Options|PostgreSQL Host Protocol Type Option |--pg-host-type|ssh|
|Stanza Options|PostgreSQL Host User Option |--pg-host-user|postgres|
|Stanza Options|PostgreSQL Path Option |--pg-path||
|Stanza Options|PostgreSQL Port Option |--pg-port|5432|
|Stanza Options|PostgreSQL Socket Path Option |--pg-socket-path||
|Stanza Options|PostgreSQL Database User Option |--pg-user||