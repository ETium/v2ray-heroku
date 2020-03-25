#!/bin/sh
# Download and install V2Ray
curl -L -H "Cache-Control: no-cache" -o /v2ray.zip https://github.com/v2ray/v2ray-core/releases/latest/download/v2ray-linux-64.zip
mkdir /usr/bin/v2ray /etc/v2ray
touch /etc/v2ray/config.json
unzip /v2ray.zip -d /usr/bin/v2ray
# Remove /v2ray.zip and other useless files
rm -rf /v2ray.zip /usr/bin/v2ray/*.sig /usr/bin/v2ray/doc /usr/bin/v2ray/*.json /usr/bin/v2ray/*.dat /usr/bin/v2ray/sys*
# V2Ray new configuration
cat <<-EOF > /etc/v2ray/config.json
{
 "inbounds": [
  {
    "sniffing": {
     "enabled": true,
     "destOverride": [
      "http",
      "tls"
     ]
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
     "network":"ws",
     "wsSettings":{
	    "path":"${PATH}"
	   }
    }
   }
  ],
  "outbounds": [
  {
    "protocol": "freedom",
    "settings": {}
  }
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
/usr/bin/v2ray/v2ray -config=/etc/v2ray/config.json
