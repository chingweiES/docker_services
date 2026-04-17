# PostgreSQL 與 Barman 備份設定與除錯指南

本文件記錄了在 PostgreSQL 資料庫中建立測試資料、設定備份權限，以及使用 Barman 進行串流備份 (Streaming Backup) 時常見的錯誤與解決步驟。

## 1. PostgreSQL 資料庫初始化與權限設定

在開始備份前，我們需要先在資料庫中建立測試資料，並確保負責備份的資料庫使用者（例如 `peter`）具有足夠的權限。

### 1.1 建立測試資料表並寫入資料

```sql
-- 建立 users 資料表
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL
);

-- 寫入範例資料
INSERT INTO users (name, email, password) VALUES
('John Doe', 'john.doe@example.com', 'password123');
```

### 1.2 設定使用者權限 (User Privileges)

負責備份或操作的使用者必須擁有相關資料表的權限，**更是必須具備 `REPLICATION` (複製) 權限**才能讓 Barman 擷取日誌。

```sql
-- 賦予 peter 在 public schema 下所有資料表的所有權限
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO peter;

-- 【重要】確保登入者擁有複製 (Replication) 權限，供 Barman 串流使用
ALTER USER peter WITH REPLICATION;
```

> **💡 補充**：如果你想確認資料表是否建立成功，可以使用以下 SQL 查詢：
> ```sql
> SELECT table_name
> FROM information_schema.tables
> WHERE table_schema = 'public';
> ```

---

## 2. Barman 系統環境與狀態檢查

在操作 Barman 前，請先確保系統資料夾權限正確，並透過內建指令檢查伺服器狀態。

### 2.1 確保目錄權限
Barman 的工作目錄必須屬於 `barman` 使用者：
```bash
sudo chown -R barman:barman /var/lib/barman
```

### 2.2 檢查 Barman 狀態
先列出伺服器，再針對特定伺服器 (假設名稱為 `pg-server`) 進行健康檢查：
```bash
# 列出已設定的伺服器
barman list-server

# 檢查伺服器狀態
barman check pg-server
```

---

## 3. 常見錯誤排除：WAL 接收與歸檔失敗

在執行 `barman check` 時，新手常會遇到以下兩個關於 WAL (Write-Ahead Logging) 的錯誤。

### 🔴 錯誤一：`receive-wal running: FAILED`
*(詳細錯誤：See the Barman log file for more details)*

**原因：** 尚未手動啟動 WAL 接收進程。Barman 必須在背景執行一個服務來「接住」資料庫傳過來的日誌。

**解決步驟：**
1. 嘗試啟動 Receive-WAL 進程：
   ```bash
   barman receive-wal pg-server
   ```
2. 如果出現以下錯誤，代表資料庫端還沒有建立對應的 Replication Slot (複製槽)：
   > `ERROR: ArchiverFailure:replication slot 'barman_slot' doesn't exist.`
3. **正確解法**：帶上 `--create-slot` 參數建立並啟動：
   ```bash
   barman receive-wal --create-slot pg-server
   ```

### 🔴 錯誤二：`WAL archive: FAILED`
*(詳細錯誤：please make sure WAL shipping is setup)*

**原因：** `barman check` 非常嚴格，它不只要看到 `pg_receivewal` 正在跑，**還要看到備份目錄裡至少有一個已經歸檔完成的 WAL 檔案**。如果沒有任何 WAL 檔案，即使連線正常也會報錯。

**解決步驟：**
手動強制 PostgreSQL 切換日誌，並讓 Barman 歸檔：
```bash
# switch-xlog 是說即使 streaming資料夾內 .patial檔案 沒有滿足切換條件，也要強制歸檔到wal資料夾
barman switch-xlog --force --archive pg-server
```
執行完後再次 `barman check pg-server`，狀態應該就會轉為 `OK`。

---

## 4. 進階概念與實用指令

### 什麼是 `barman receive-wal`？
`barman receive-wal pg-server` 這條指令的動作叫做**「啟動串流日誌接收 (Streaming WAL Reception)」**。
就像是在 Barman 與 PostgreSQL 之間接了一根即時傳輸的水管：
* **建立持久連線**：Barman 會利用 `streaming_conninfo` 連線到 PostgreSQL 的 Replication 協定。
* **即時監聽變動**：它告訴 PostgreSQL：「只要有任何變動產生 WAL，請立刻發送給我。」
* **寫入本地檔案**：當資料庫發生交易（Insert/Update/Delete）時，變動會即時寫入 Barman 容器內的 `wals` 目錄下。
* **達成 RPO ≈ 0**：因為是「串流」，即使還沒執行完整備份 (`barman backup`)，只要這個進程在跑，最後一秒的交易也已經存檔。

### 實用指令：尋找 Barman 的根目錄與 WAL 位置
有時候我們需要進去看實際存放的 WAL 檔案，可以透過以下指令找出 `barman_home` (通常也是 `wals` 的存放地)：
```bash
barman show-server pg-server | grep barman_home
```




基礎備份
barman backup pg-server
備份最後一次到 /var/lib/barman/recovery-test
barman recover pg-server latest /var/lib/barman/recovery-test

sudo chown -R 999:999 /var/lib/barman/recovery-test
sudo chmod 700 /var/lib/barman/recovery-test

docker run -d \
  --name postgres_recovered \
  -p 9077:5432 \
  -v ./barman_data/recovery-test:/var/lib/postgresql/data \
  -e POSTGRES_PASSWORD=peteradmin \
  postgres:14
