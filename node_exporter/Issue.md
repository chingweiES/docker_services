
# 監控系統追蹤紀錄 (Issue Tracker)

## 

- **問題標題**: Error response from daemon: path / is mounted on / but it is not a shared or slave mount
- **環境**: Windows 11 + WSL2 + Docker Compose
- **狀態**: ✅ 已解決 (Resolved)

---

## 根本原因分析 (RCA)
- 這個錯誤是因為你嘗試在 volumes 中使用 :rslave 模式掛載根目錄 /，但你的宿主機（Host）作業系統將根目錄掛載為 private 模式，這不允許子目錄（容器內部）接收來自掛載點的變動。

## 解決方案

- **修改掛載模式**: 將 :rslave 改為 :rprivate，這樣就不會嘗試從宿主機接收變動，避免了這個錯誤。

```yaml
    volumes:
      - /proc:/host/proc:ro
      - /sys:/host/sys:ro
      - /:/rootfs:ro  # 移除 rslave，改回單純的 ro
```

---

## 📂 專案資訊
- **問題標題**: WSL2 環境下 Prometheus 無法抓取 Node Exporter 指標 (Connection Hang)
- **環境**: Windows 11 + WSL2 + Docker Compose (otel-lgtm stack)
- **狀態**: ✅ 已解決 (Resolved)

---

## 📝 問題描述
在使用 Docker 部署 `node-exporter` 與 `otel-lgtm` (含 Prometheus) 時，發現以下異常：
1. **外部存取正常**: 從 Windows 瀏覽器訪問 `http://localhost:9100/metrics` 可看見數據。
2. **容器內部失敗**: `otel-lgtm` 容器日誌顯示抓取超時 (Context Deadline Exceeded)，Grafana 顯示 "No Data"。
3. **CLI 異常**: 在 WSL 終端機執行 `curl http://<WSL_IP>:9100` 會直接卡住 (Hang)，但加上 `--noproxy "*"` 則秒回。

---

## 🔍 根本原因分析 (RCA)
- **代理干擾 (Proxy Issue)**: WSL 系統環境變數設定了 `http_proxy`，導致所有請求預設轉向 Windows 上的代理伺服器。
- **路由循環**: 代理伺服器無法將針對 WSL 內部私有 IP (`172.24.x.x`) 的請求正確導回 WSL，導致連線掛起。

---

## 🛠 解決方案

### 1. 修改 `otel-lgtm` 的環境變數
在 `docker-compose.yml` 中強制加入 `NO_PROXY`，排除內部通訊網段：

```yaml
services:
  otel-lgtm:
    environment:
      - NO_PROXY=127.0.0.1,localhost,172.24.97.67
      - no_proxy=127.0.0.1,localhost,172.24.97.67
```

### 2. 同步 `otel-config.yaml` 設定
確保抓取目標指向正確的 WSL IP：

```yaml
receivers:
  prometheus:
    config:
      scrape_configs:
        - job_name: "node-exporter"
          static_configs:
            - targets: ["172.24.97.67:9100"]
```

---

## 📜 自動化檢查腳本 (Bash)
可將以下代碼存為 `check_monitor.sh` 用於快速排查：

```bash
#!/bin/bash
WSL_IP=$(hostname -I | awk '{print $1}')
echo "--- 偵測到當前 WSL IP: $WSL_IP ---"

# 測試連線
echo "正在測試連線狀態..."
TEST_200=$(curl -o /dev/null -s -w "%{http_code}" --noproxy "*" --max-time 2 http://$WSL_IP:9100/metrics)

if [ "$TEST_200" = "200" ]; then
    echo "[SUCCESS] Node Exporter 連線成功！"
else
    echo "[FAILED] 連線失敗，請檢查 9100 埠是否開啟。"
fi
```

---

## 💡 經驗總結
在 WSL2/Docker 環境下進行內部服務串接時，應優先檢查是否受到 **宿主機代理 (Global Proxy)** 的干擾。對於本地端 (Intranet) 的流量，務必設定 `NO_PROXY` 環境變數。
