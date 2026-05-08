歸檔流程是 PostgreSQL 主動觸發 的。
PostgreSQL 就像一個「發案者」，每當它寫滿一個日誌檔（WAL segment，通常 16MB），它就會主動呼叫 archive_command，命令 pgBackRest（接案者）去把檔案搬走。pgBackRest 不會 主動去輪詢（Poll）資料庫。
這就是為什麼如果你在 postgresql.conf 裡的 archive_command 設錯了，歸檔就會立刻停止。
1
1. 寫滿日誌 (PostgreSQL)
PostgreSQL 的背景行程不斷寫入交易日誌。當一個 WAL 檔案（例如 00000001...A）被寫滿 16MB 並切換到下一個檔案時，觸發歸檔機制。
2
2. 發出指令 (PostgreSQL)
PostgreSQL 根據設定檔執行指令：
pgbackrest --stanza=main archive-push pg_wal/00000001...A
這時候 PostgreSQL 會暫停對該檔案的處理，等待指令回傳結果。
3
3. 執行搬運 (pgBackRest)
pgBackRest 收到指令：
檢查該檔案是否正確。
進行壓縮、加密（如果有的話）。
將檔案 Push 到遠端儲存庫（S3 / NFS）。
4
4. 回報結果 (PostgreSQL)
如果成功：pgBackRest 回傳 exit code 0。PostgreSQL 標記該檔案為「已歸檔」，並在未來允許回收空間。
如果失敗：pgBackRest 回傳錯誤碼。PostgreSQL 會保留該檔案，並在短暫延遲後無限重試步驟 2，直到成功為止（這就是為什麼失敗會導致硬碟爆滿）。
關鍵差異：開啟 archive-async=y 後的流程
既然你之前問到了 archive-async，這個設定會改變上述的第 2 和第 3 步：
標準模式（Sync）：PostgreSQL 必須等 pgBackRest 真的把檔案上傳到 S3 完成後，才收得到「成功」的訊號。如果 S3 慢，PostgreSQL 就會覺得歸檔很慢。
非同步模式（Async）：
PostgreSQL 呼叫 pgBackRest。
pgBackRest 只要把檔案複製到本地的一個暫存資料夾（Spool Path），就立刻跟 PostgreSQL 說「好了，成功！」。
PostgreSQL 繼續工作，不被卡住。
pgBackRest 的另一個背景行程（Worker）會慢慢地把暫存區的檔案上傳到 S3。



## 情境1 - 資料庫長大樹率較慢

* 問題: 最大的風險是RPO（恢復點目標）過長，因為WAL檔案可能會在本地暫存區停留較長時間，直到被上傳到S3。這意味著如果發生故障，你可能只能恢復到最後一次成功上傳的WAL檔案，而不是最新的狀態。 (可能要好幾天)