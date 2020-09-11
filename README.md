# V2Ray Heroku

## ENV 设定

### UUID

`UUID` > `一个 UUID，供用户连接时验证身份使用`。
`WSPATH` > `WSPATH路径`。

## 注意

AlterID 为 10。

V2Ray 将在部署时自动安装最新版本。

**出于安全考量，除非使用 CDN，否则请不要使用自定义域名，而使用 Heroku 分配的二级域名，以实现 V2Ray Websocket + TLS。**
