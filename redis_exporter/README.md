# Redis-exporter

## 版本

- redis_exporter: v1.83.0-alpine

* 沒有bash 只有基本的sh

CMD-SHELL wget -qO- http://localhost:9121/metrics | grep -q 'redis_up' 

## 密碼操作

* 目前的密碼是放在secret裡面，並且以json的格式儲存，格式為：

```json
{
  "redis://monitor_user@redis_master:6379": "monitor123"
}
```
* 先掛載密碼檔案到容器內的 /etc/redis-exporter/password.json

* 使用Command來讀取密碼：
```yml
    command:
      - "--redis.password-file=/etc/redis-exporter/password.json"
```