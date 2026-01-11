# 统一支付下单 OpenAPI 对接文档

## 1. 版本信息

- 版本：v1
- 最后更新：2026-01-10
- 适用系统：novel-front

## 2. 接入方配置

由平台在 `openapi_app` 表中配置：

- `app_id`：接入方标识
- `app_secret`：签名密钥
- `notify_url`：默认异步回调地址（可被接口参数覆盖）
- `return_url`：默认同步跳转地址（可被接口参数覆盖）
- `ip_whitelist`：白名单，逗号分隔（可选）
- `max_qps` / `day_limit`：限流阈值（可选）

## 3. 签名与鉴权

### 3.1 请求头/参数

必须携带（Header 或请求参数均可）：

- `app_id`
- `timestamp`（毫秒时间戳；若为秒，后端会自动乘 1000）
- `nonce`
- `sign`

### 3.2 签名算法

- `sign = HMAC-SHA256(app_secret, canonical_string)`
- `canonical_string`：请求参数按 key 字典序升序拼接，格式 `k1=v1&k2=v2...`
- `sign` 需小写 hex
- 参数中不能包含 `sign` 本身

示例（伪代码）：

```
params = {
  app_id, timestamp, nonce,
  external_order_no, external_user_id, amount, subject
}
canonical = sort(params).join("&")
sign = hmac_sha256(app_secret, canonical)
```

### 3.3 防重放

- `timestamp` 与服务端时间差不超过 5 分钟
- `nonce` 5 分钟内不可重复

## 4. 下单接口

### 4.1 地址

`POST /openapi/pay/alipay/create`

### 4.2 请求参数（x-www-form-urlencoded）

必传：

- `external_order_no`：接入方订单号（幂等）
- `external_user_id`：接入方用户 ID
- `amount`：金额（单位：分）
- `subject`：订单标题

建议传：

- `alipay_user_id`：支付宝 UID（不允许重绑）

可选：

- `alipay_account`
- `alipay_real_name`
- `body`
- `notify_url`
- `return_url`
- `attach`
- `type_index`（默认 2）
- `goods_type`（默认 9）

### 4.3 响应

```
{
  "code": 200,
  "msg": "ok",
  "data": {
    "orderNo": "202601101719074716",
    "externalOrderNo": "EXT-2024-0001",
    "status": "CREATED",
    "payType": "alipay",
    "payData": {
      "gatewayUrl": "http://47.99.180.68:8060/api/pay/operPay",
      "body": "clientIp=...&merTradeNo=...&sign=...",
      "headers": {
        "timeStamp": "1768036747",
        "visitAuth": "xxxx"
      }
    },
    "userId": 1997843516947996672
  }
}
```

### 4.4 幂等规则

`app_id + external_order_no` 唯一：

- 重复请求返回同一笔订单与支付信息

## 5. 订单查询接口

### 5.1 地址

`GET /openapi/pay/order/query?external_order_no=...`

### 5.2 响应

```
{
  "code": 200,
  "msg": "ok",
  "data": {
    "order_no": "202601101719074716",
    "external_order_no": "EXT-2024-0001",
    "status": 0,
    "amount": 3000
  }
}
```

## 6. 异步回调（小说站 -> 接入方）

### 6.1 触发

支付成功后调用接入方 `notify_url`。

### 6.2 回调参数（x-www-form-urlencoded）

- `app_id`
- `external_order_no`
- `order_no`
- `amount`（分）
- `trade_no`（支付交易号）
- `status`（1 表示已支付）
- `attach`
- `timestamp`
- `nonce`
- `sign`

### 6.3 回调签名

同请求签名规则：HMAC-SHA256(app_secret, canonical_string)

### 6.4 重试策略

失败重试 5 次，间隔：1s / 5s / 15s / 30s / 60s（基于任务表 + 定时调度）。

## 7. 错误码说明（常见）

- `20001`：openapi鉴权失败
- `20002`：接入方不可用
- `20003`：签名错误
- `20004`：请求已过期
- `20005`：重复请求
- `20006`：请求过于频繁
- `20007`：支付宝用户冲突（不允许重绑）
- `20009`：参数错误

## 9. 回调任务表字段说明

表名：`openapi_notify_task`

字段：

- `id`：主键
- `app_id`：接入方ID
- `notify_url`：回调地址
- `external_order_no`：接入方订单号
- `out_trade_no`：本地订单号
- `amount`：金额（分）
- `trade_no`：支付交易号
- `attach`：透传字段
- `status`：0待处理 1处理中 2成功 3失败
- `retry_count`：已重试次数
- `max_retry`：最大重试次数
- `next_retry_time`：下次重试时间
- `last_error`：最后一次错误
- `create_time` / `update_time`：创建/更新时间

## 10. 后台接口（管理侧）

### 10.1 回调任务列表

`GET /novel/openapiNotifyTask/list`

参数：

- `status`：可选，0/1/2/3
- `limit` / `offset`：分页

### 10.2 手动重试

`POST /novel/openapiNotifyTask/retry`

参数：

- `id`：任务ID

## 8. 示例请求

```
POST /openapi/pay/alipay/create
Content-Type: application/x-www-form-urlencoded

app_id=app123&timestamp=1768036747000&nonce=abc123&sign=...&
external_order_no=EXT-2024-0001&external_user_id=U123&amount=3000&subject=充值
```
