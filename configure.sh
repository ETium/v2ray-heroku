#!/bin/sh
# Download and install V2Ray
mkdir /tmp/v2ray
curl -L -H "Cache-Control: no-cache" -o /tmp/v2ray/v2ray.zip https://github.com/v2ray/v2ray-core/releases/latest/download/v2ray-linux-64.zip
unzip /tmp/v2ray/v2ray.zip -d /tmp/v2ray
install -m 755 /tmp/v2ray/v2ray /usr/local/bin/v2ray
install -m 755 /tmp/v2ray/v2ctl /usr/local/bin/v2ctl
# Remove temporary directory
rm -rf /tmp/v2ray
# V2Ray new configuration
install -d /usr/local/etc/v2ray
cat <<-EOF > /usr/local/etc/v2ray/config.json
{
 "inbounds": [
  {
    "sniffing": {
     "enabled": true,
     "destOverride": ["http","tls"]
    },
    "port": ${PORT},
    "protocol": "vmess",
    "settings": {
      "clients": [
        {
          "id": "${UUID}",
          "alterId": 10
        }
      ],
	"disableInsecureEncryption": true
    },
    "streamSettings": {
     "network": "ws",
     "wsSettings": {"path":"/Share/"}
    }
   }
  ],
  "outbounds": [
  {
    "protocol": "freedom",
    "settings": {}
  },
  {
    "protocol": "blackhole",
    "settings": {},
    "tag": "blocked"
  }
 ],
 "routing": {
  "rules": [
   {
    "type": "field",
    "outboundTag": "blocked",
    "protocol": [
     "bittorrent"
    ]
   }
  ]
 },
 "dns": {
  "servers": [
   "https+local://1.1.1.1/dns-query",
   "1.1.1.1",
   "1.0.0.1",
   "8.8.8.8",
   "8.8.4.4",
   "localhost"
  ]
 }
}
EOF
/usr/local/bin/v2ray -config=/usr/local/etc/v2ray/config.json
