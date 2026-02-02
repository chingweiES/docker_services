# 設定行為

*  兩邊的user管理是獨立的
*  ACL 預設就會開啟，但是aclfile要自己決定要不要有。預設會有* defualt user並且不用password。
*  appendonly 
*  使用TLS/SSL進行加密連線。
*  replica，master有可能會斷線，redis會嘗試重新連線。
* 哨兵模式: replica 自動轉換成 master，IP自動更新。

# Log注意:

* 如果log有較多的FULLRESYNC(全量同步)，調大 Master 端的 repl-backlog-size。
* 

# 注意操作

* docker 中要設定 daemonize 為no。
* 

# master 設定

|項目|建議程度|說明|
|---|---|---|
||||
|repl-backlog-size|中|Master 記憶體中預留空間，讓斷線重連的 Replica 可以進行「增量同步|
|tcp-backlog 2048|||
|repl-ping-replica-period|master依據這個週期發起PING|這個值要小於repl-timeout。一般repl-timeout大概是4~10倍|
||||

# replica 設定

|項目|建議程度|說明|
|---|---|---|
|replica-read-only|設定yes|
|replicaof|<Master_IP> <Master_Port>|啟動replica角色|
|masteruser|連線master的使用者||
|masterauth|連線master的密碼||
||||
||||


# master replica 推薦設定

|||
|---|---|
|protected-mode|都要設定yes||
|requirepass|replica 連線 master，user連線master都需要，兩個密碼用不一樣|
|databases|數量設定要一樣|
|syslog-enabled|設定yes，開始做檔案輸出 (搭配logfile)|
|logfile|各自的log|
|aclfile|acl檔案各自有自己的acl log|
|crash-log-enabled, crash-memcheck-enabled|設定yes，執行崩潰的瞬間檢查|
|repl-timeout|若超過這個時間，master與replica 斷掉。replica看:偵測master在SYNC/PSYNC以及Data and PINGs有逾時。master看: 會定期接收來自replica的確認訊息（ACK。調高(600seconds)。|
|||

# master replica 不一定設定

|||
|---|---|
|appendonly|兩邊都設定，保留備份。只在slave，讓slave承擔寫入硬碟工作就好|
|tcp-keepalive|預設300改成60秒就好|
|||
|||