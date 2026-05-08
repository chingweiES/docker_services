# 使用:

* 使用 /home/steven/docker_services/docker-otel-lgtm/docker 自己Build
* image為: grafana/otel-lgtm   steven   2026-05-05 13:55:28 +0800 CST

## otelcol-config.yaml

* otelcol-config.yaml

1. 是 OpenTelemetry Collector (Otel Col) 的核心設定檔。想像成一個「資料轉運站」。
2. 定義資料如何 接收 (Receive)、處理 (Process) 並 輸出 (Export)。
3. 主要包含三個部分：
   - **接收器 (Receivers)**：定義資料從哪裡來。例如，從應用程式、系統或其他來源接收資料。
   - **處理器 (Processors)**：定義如何處理接收到的資料。例如，過濾、轉換或增強資料。
   - **導出器 (Exporters)**：定義資料要送到哪裡去。例如，送到監控系統、日誌系統或其他分析工具。

### service block:


|||
|---|---|
|traces|指的是分散式追蹤資料，通常用於追蹤應用程式中的請求流動。|
|metrics|指的是指標資料，通常用於監控系統的性能和健康狀態。|
|logs|指的是日誌資料，通常用於記錄應用程式的事件和錯誤。|
|profiles|指的是性能分析資料，通常用於分析應用程式的性能瓶頸。|

```yaml
service:
  extensions: [health_check]
  pipelines:
    traces:
      receivers: [otlp]
      processors: [batch]
      exporters: [otlp_http/traces]
      #exporters: [otlp_http/traces,debug/traces]
    metrics:
      receivers: [otlp, prometheus/collector, prometheus/redis]
      processors: [batch]
      exporters: [otlp_http/metrics]
      #exporters: [otlp_http/metrics,debug/metrics]
```

===
「我要啟動一條指標管線，從名為 prometheus/redis 的接收器抓資料，處理後送出去。」
===

* 到 receivers的 prometheus/redis 定義裡面去找，看看它是怎麼接收資料的。