#!/bin/bash
yum -y update
yum -y install epel-release
yum -y update
yum -y install openvpn wget bzip2 bzip2-libs iptables iptables-services
wget http://repo.mysql.com/mysql-community-release-el7-5.noarch.rpm
rpm -ivh mysql-community-release-el7-5.noarch.rpm
yum -y update
systemctl start mysqld
touch /etc/openvpn/server.conf
echo "port 443" >> /etc/openvpn/server.conf
echo "proto udp" >> /etc/openvpn/server.conf
echo "dev tun" >> /etc/openvpn/server.conf
echo "ca ca.crt" >> /etc/openvpn/server.conf
echo "cert server.crt" >> /etc/openvpn/server.conf
echo "key server.key  # This file should be kept secret" >> /etc/openvpn/server.conf
echo "dh dh.pem" >> /etc/openvpn/server.conf
echo "server 10.10.0.0 255.255.0.0" >> /etc/openvpn/server.conf
echo "ifconfig-pool-persist /var/log/openvpn/ipp.txt" >> /etc/openvpn/server.conf
echo 'push "redirect-gateway def1 bypass-dhcp"' >> /etc/openvpn/server.conf
echo 'push "dhcp-option DNS 208.67.222.222"' >> /etc/openvpn/server.conf
echo 'push "dhcp-option DNS 208.67.220.220"' >> /etc/openvpn/server.conf
echo "keepalive 10 120" >> /etc/openvpn/server.conf
echo "tls-auth ta.key 0 # This file is secret" >> /etc/openvpn/server.conf
echo "client-to-client" >> /etc/openvpn/server.conf
echo "username-as-common-name" >> /etc/openvpn/server.conf
echo "client-cert-not-required" >> /etc/openvpn/server.conf
echo "auth-user-pass-verify /etc/openvpn/script/login.sh via-env" >> /etc/openvpn/server.conf
echo "cipher AES-256-CBC" >> /etc/openvpn/server.conf
echo "auth SHA256" >> /etc/openvpn/server.conf
echo "user nobody" >> /etc/openvpn/server.conf
echo "group nobody" >> /etc/openvpn/server.conf
echo "persist-key" >> /etc/openvpn/server.conf
echo "persist-tun" >> /etc/openvpn/server.conf
echo "status openvpn-status.log" >> /etc/openvpn/server.conf
echo "verb 3" >> /etc/openvpn/server.conf
echo "explicit-exit-notify 1" >> /etc/openvpn/server.conf
echo "script-security 3" >> /etc/openvpn/server.conf
echo "client-connect /etc/openvpn/script/connect.sh" >> /etc/openvpn/server.conf
echo "client-disconnect /etc/openvpn/script/disconnect.sh" >> /etc/openvpn/server.conf
touch /etc/openvpn/ca.crt
echo "-----BEGIN CERTIFICATE-----
MIIDNTCCAh2gAwIBAgIJAMh9zLNa5YZTMA0GCSqGSIb3DQEBCwUAMBYxFDASBgNV
BAMMC0Vhc3ktUlNBIENBMB4XDTIwMDEwMjA5MzcxOFoXDTI5MTIzMDA5MzcxOFow
FjEUMBIGA1UEAwwLRWFzeS1SU0EgQ0EwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAw
ggEKAoIBAQDME8bTgU/4UMIDItk+vnnvRUs9NsqNUSHjQ6CRtxOpTjwxr2tqX5Bo
tTjtQ391siQmDgggzbSMsKumQ1nMj2QnXm7O2kxoaSe7PiT97R+lkBuXOJf2PQJs
uXfrIqePcG3EJd4RuOIabgfIVcqQ3+06pPeRoeBHnQVtl/7tN6DZG3VjZcid2eem
x43szipIHirxdSi+UWno2i97/JXeLkPg4Jrirc3o93FhGnCRRCfI+AczMxvJ72K1
UyeGZXezbGTwXxjRlkUp4Qy3YyN/ewauddcDur6Af1xxQTSyxfiaO4SCUpSXGS5K
mJ6jwa+dIyreGoRYd0kWA4sMLYYreHxlAgMBAAGjgYUwgYIwHQYDVR0OBBYEFM+i
ppX2XwXwHrII6cuMNMuYx3oQMEYGA1UdIwQ/MD2AFM+ippX2XwXwHrII6cuMNMuY
x3oQoRqkGDAWMRQwEgYDVQQDDAtFYXN5LVJTQSBDQYIJAMh9zLNa5YZTMAwGA1Ud
EwQFMAMBAf8wCwYDVR0PBAQDAgEGMA0GCSqGSIb3DQEBCwUAA4IBAQCQSjajFimc
KcnoHl7PwSBKvnmF2HdqfRKh7EF1Zhbgk7nXsm8nbnv9D50cJdGBUUKgaayfnZ8e
LZODsUkK2GomsWcr/g7HDEoL4w75f6+t6Y8LUbiKylmKbeF/EBSBGsxYibip5wBJ
oJSIC4VbL5JqGEHWlLu3ZtJlFWlAETALXY7ItWCwkw7wsfn63ToecDNRAkKLP6Vs
RwPIciHIBJBAizDRpQVtKsW97dzSEJfhomDQhx6Ssp9GIYbPUWHhEdbYyyvPrcgl
OUB53RPVGxIHX7qIfs3x4VU6AkO9VynY9KEauc0Vc1hdd3o55vwtfFaTaJE0Kj85
oqlVQSXKU5ZX
-----END CERTIFICATE-----" >> /etc/openvpn/ca.crt
touch /etc/openvpn/dh.pem
echo "-----BEGIN DH PARAMETERS-----
MIIBCAKCAQEA8H9oKOVxDYg+A4whGt7/feCajugBMvl+xmlmQLnIOoXch2ndBN8T
xRyWDDwMmo+bIpAs9uEcJid/Eoo+B7+UcYgg2/y3lQDOqdn3unYHae+as50jFPYl
Ud26mMjlGSN5JIhDRMS+MyrmsNgKWAierjnpw3UzrRwWBf94apqR6uXoR4dskQbY
KPyc/qtawW/0TZgUlTphmEDAUWWNBQnUbDOByZsQ/cqXmK2Cb4ogekpWJ7Ztza1i
W345CWuzb6VYJWAo9xMIbg7HGVr5FudtNUvRHSMviRqnlzbOfOEMpLzjdGlmraY4
j6gdZWFStWTuqaSCKQqE93tn5rYYZ2vjewIBAg==
-----END DH PARAMETERS-----" >> /etc/openvpn/dh.pem
touch /etc/openvpn/server.key
echo "-----BEGIN PRIVATE KEY-----
MIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQDYkj2a4MEkqYBr
TdaH45aS1HYdvKWQVAT2kwh4q1W39IaTlPqZR5PnvVy3E3xB2q6UA6RsGq67VJpZ
KkbAUkQdSvLbN/WHRkfQ5CrQ5Q1141EXQeaoXH3/Tc0IUYLmATbYQLgPAgbuJu3p
xAf8JvF/RPXGqjLfInInNIOlUHpQXcEqN1v2dPOF0GEWbCxXNW/vc8Ou8TE8N/8M
zLHfH8E2E+9fGUztb2Vf+ffYa35WUhC9bfc+niJ8lO5GUtBsEcrEwUrtbBqm+MPF
vPJUoT0pnk7vzTTxqt7NfHGUZlHxt4syQfA0zxvmElT42Cx+Ww5SbiPTPNtPnGdy
v9lQnICNAgMBAAECggEBALnpWC8TD1psk4wJxsbibUjgUAEZBzuNlLEi6RvFYRFI
PRqFwlZApsxBt0yF0p4pnsH7GnOeuC6h4tn2O8QvGr/WrgHX2NLmVxIQPF0Us+hm
Wh9P+DTBKXw3inHAn1DY6/7aF+byQ4a/Lm8FVCF2QMuTJDUFuCPqSvoyz2vjWQyQ
yoC69TTDsCL3t07gxTdUnFSMTTpQxUrMxi1sZ5AOGdHg8d4EbsLHlMW+GDGH4LXc
m/Hf1N2KywT8P1uoUeil9P5ZsRbsq7caDSZ+R7TW7PWCD1QsgLKR4sfiFXCQqYOu
cCL/muMUppfhUMuhKQe1fi20GubPT2plaoQOdEe/TSECgYEA9S/PBqTIiNP5hZn6
6XWej7/CGYvI27lHXpFmeK6BCWPUaumv0iZLn1tiLIU2dxT7zj+sJCn6xFzw6mZP
TvYnFjEp/7TF4RM0y0L0JW7JHrUOx2Od5r/LHwxxu+T2I20wkfCtu38NPCjh8OD3
jELXf3DZxQHzk/G8BImpha9WvHkCgYEA4h9b7wu/jTTTyNvSmRsgDG76VKfUGopc
f5T0xyHqKM/bDiKcpSZsVytMkng+DPeWYnXEhisYiZgrhiOpQWCxxvRBlwTNp9as
51lRv2/vtYWBln1wESyBp5VfVz+NjK1c0wRum0proc5O1/gSCkHKghpRJ2dBvghu
IGw2EGbVd7UCgYAtEuzsO77h6JYmiXgnEwhjRM1aBOiX/Ceyqug7p1jxcPjL7snz
yDZ+xT33EUZB/gmMkQgEXfNLxgpEDSrnSTlGSyN9bq4yAmXiOBzKBOPUUVS2MwoE
MZ4VxyPhduYI/TnAmo5VubWlKZ7fuXvIvUEAnK5sGT++IuJ9sxEHEoTPgQKBgCXg
nuPCEgozSS6iM/rVol6y0FgR7OOtPaVZbE9XDQRdHRKXFapMb2WCqUb3wV0mtBg2
Jf9bhLa3uMK1goqjCeSL0djcQx7URQ5T1e+9bmf3vydYR8d4rxdFXD0fNjTUbXIj
keuNYc4u4uImec8iCiwVAHcbQtX0T4460iuZLjTpAoGBANaaOYWKXIQJ2xcy9DtB
YjSsy3OZ1KWWuEzHwBMb6CR0PWudrvhm24cYJk2JEU8qRwqMN50gQKNQpYAFM47c
xORIgYcwnH0efU5zzeWCqRO174tLDq9GK67V3tqc5cSJbFqbky14y7kdpZt9Aco6
9pyvpb4ZCv9eS8tASK1Ti92V
-----END PRIVATE KEY-----" >> /etc/openvpn/server.key
touch /etc/openvpn/server.crt
echo "Certificate:
    Data:
        Version: 3 (0x2)
        Serial Number:
            5e:b7:a7:08:6e:68:b3:a7:ed:8f:76:eb:66:54:3e:4c
    Signature Algorithm: sha256WithRSAEncryption
        Issuer: CN=Easy-RSA CA
        Validity
            Not Before: Jan  2 09:37:22 2020 GMT
            Not After : Dec 30 09:37:22 2029 GMT
        Subject: CN=server
        Subject Public Key Info:
            Public Key Algorithm: rsaEncryption
                Public-Key: (2048 bit)
                Modulus:
                    00:d8:92:3d:9a:e0:c1:24:a9:80:6b:4d:d6:87:e3:
                    96:92:d4:76:1d:bc:a5:90:54:04:f6:93:08:78:ab:
                    55:b7:f4:86:93:94:fa:99:47:93:e7:bd:5c:b7:13:
                    7c:41:da:ae:94:03:a4:6c:1a:ae:bb:54:9a:59:2a:
                    46:c0:52:44:1d:4a:f2:db:37:f5:87:46:47:d0:e4:
                    2a:d0:e5:0d:75:e3:51:17:41:e6:a8:5c:7d:ff:4d:
                    cd:08:51:82:e6:01:36:d8:40:b8:0f:02:06:ee:26:
                    ed:e9:c4:07:fc:26:f1:7f:44:f5:c6:aa:32:df:22:
                    72:27:34:83:a5:50:7a:50:5d:c1:2a:37:5b:f6:74:
                    f3:85:d0:61:16:6c:2c:57:35:6f:ef:73:c3:ae:f1:
                    31:3c:37:ff:0c:cc:b1:df:1f:c1:36:13:ef:5f:19:
                    4c:ed:6f:65:5f:f9:f7:d8:6b:7e:56:52:10:bd:6d:
                    f7:3e:9e:22:7c:94:ee:46:52:d0:6c:11:ca:c4:c1:
                    4a:ed:6c:1a:a6:f8:c3:c5:bc:f2:54:a1:3d:29:9e:
                    4e:ef:cd:34:f1:aa:de:cd:7c:71:94:66:51:f1:b7:
                    8b:32:41:f0:34:cf:1b:e6:12:54:f8:d8:2c:7e:5b:
                    0e:52:6e:23:d3:3c:db:4f:9c:67:72:bf:d9:50:9c:
                    80:8d
                Exponent: 65537 (0x10001)
        X509v3 extensions:
            X509v3 Basic Constraints: 
                CA:FALSE
            X509v3 Subject Key Identifier: 
                4E:49:19:70:CE:E3:75:5E:6C:A2:34:17:27:D7:6D:9E:94:D0:78:50
            X509v3 Authority Key Identifier: 
                keyid:CF:A2:A6:95:F6:5F:05:F0:1E:B2:08:E9:CB:8C:34:CB:98:C7:7A:10
                DirName:/CN=Easy-RSA CA
                serial:C8:7D:CC:B3:5A:E5:86:53

            X509v3 Extended Key Usage: 
                TLS Web Server Authentication
            X509v3 Key Usage: 
                Digital Signature, Key Encipherment
            X509v3 Subject Alternative Name: 
                DNS:server
    Signature Algorithm: sha256WithRSAEncryption
         22:87:db:29:7d:36:a2:54:8a:3c:88:3b:2f:f6:3f:4b:da:88:
         a9:2e:b3:cd:f1:86:d2:67:47:7f:f3:66:cc:38:4f:5a:17:4c:
         47:5a:d9:1e:4f:76:79:bc:c7:1a:15:13:6c:7f:d9:66:f4:f7:
         65:09:3e:d2:83:0f:6a:ee:c7:c8:14:4e:42:31:08:7f:97:b7:
         32:4e:f1:69:57:08:80:f0:c1:c3:4a:18:e3:e2:26:7e:cc:5c:
         67:e9:2e:81:9a:a8:2a:58:c1:ed:3a:d0:01:37:8d:8b:b2:3a:
         a0:ed:18:0c:5d:39:d8:3d:98:63:56:a5:55:5b:ca:0f:04:36:
         b1:28:75:30:86:7b:74:9b:e3:d2:5d:b7:a3:ba:c1:e9:c2:41:
         8f:8c:19:00:bf:0b:4f:ab:a1:ff:a9:03:ba:3b:9a:00:0d:b3:
         3a:23:8b:89:39:e7:15:f3:d0:19:01:4e:9a:f5:6d:96:cc:7a:
         06:f6:6d:c4:4b:74:c4:b4:e9:f8:4e:cd:7a:7c:61:ad:92:62:
         9a:6a:0e:7b:f5:5d:e1:85:0d:0d:c9:f6:cf:58:b2:1f:20:03:
         02:be:6d:62:ae:21:6d:9a:5c:a8:25:ef:d6:bf:84:1a:0e:76:
         9c:7e:6a:06:cc:fe:8d:4e:26:4e:5f:96:b6:95:8d:79:4f:78:
         71:24:39:1d
-----BEGIN CERTIFICATE-----
MIIDXDCCAkSgAwIBAgIQXrenCG5os6ftj3brZlQ+TDANBgkqhkiG9w0BAQsFADAW
MRQwEgYDVQQDDAtFYXN5LVJTQSBDQTAeFw0yMDAxMDIwOTM3MjJaFw0yOTEyMzAw
OTM3MjJaMBExDzANBgNVBAMMBnNlcnZlcjCCASIwDQYJKoZIhvcNAQEBBQADggEP
ADCCAQoCggEBANiSPZrgwSSpgGtN1ofjlpLUdh28pZBUBPaTCHirVbf0hpOU+plH
k+e9XLcTfEHarpQDpGwarrtUmlkqRsBSRB1K8ts39YdGR9DkKtDlDXXjURdB5qhc
ff9NzQhRguYBNthAuA8CBu4m7enEB/wm8X9E9caqMt8icic0g6VQelBdwSo3W/Z0
84XQYRZsLFc1b+9zw67xMTw3/wzMsd8fwTYT718ZTO1vZV/599hrflZSEL1t9z6e
InyU7kZS0GwRysTBSu1sGqb4w8W88lShPSmeTu/NNPGq3s18cZRmUfG3izJB8DTP
G+YSVPjYLH5bDlJuI9M820+cZ3K/2VCcgI0CAwEAAaOBqjCBpzAJBgNVHRMEAjAA
MB0GA1UdDgQWBBROSRlwzuN1XmyiNBcn122elNB4UDBGBgNVHSMEPzA9gBTPoqaV
9l8F8B6yCOnLjDTLmMd6EKEapBgwFjEUMBIGA1UEAwwLRWFzeS1SU0EgQ0GCCQDI
fcyzWuWGUzATBgNVHSUEDDAKBggrBgEFBQcDATALBgNVHQ8EBAMCBaAwEQYDVR0R
BAowCIIGc2VydmVyMA0GCSqGSIb3DQEBCwUAA4IBAQAih9spfTaiVIo8iDsv9j9L
2oipLrPN8YbSZ0d/82bMOE9aF0xHWtkeT3Z5vMcaFRNsf9lm9PdlCT7Sgw9q7sfI
FE5CMQh/l7cyTvFpVwiA8MHDShjj4iZ+zFxn6S6BmqgqWMHtOtABN42Lsjqg7RgM
XTnYPZhjVqVVW8oPBDaxKHUwhnt0m+PSXbejusHpwkGPjBkAvwtPq6H/qQO6O5oA
DbM6I4uJOecV89AZAU6a9W2WzHoG9m3ES3TEtOn4Ts16fGGtkmKaag579V3hhQ0N
yfbPWLIfIAMCvm1iriFtmlyoJe/Wv4QaDnacfmoGzP6NTiZOX5a2lY15T3hxJDkd
-----END CERTIFICATE-----" >> /etc/openvpn/server.crt
touch /etc/openvpn/ta.key
echo "#
# 2048 bit OpenVPN static key
#
-----BEGIN OpenVPN Static key V1-----
57061e5e81c763fb6ec74fbf14610f91
76ec7fd8e7e70ccd082b250415d2e1ab
9802acd8b16a8f17296d1eab95ad174c
6111bfa4e22e1832897db4cc747d7819
f78f74a9bb12588eb871ab4dd6efcfc3
05963e5e4562eb7198b17b32e02dce29
8fc35f9272bf1b724cb61fa62f042a1e
b1d89a94f58c0fc78759bed23893b31e
d1e67e6af2a92ac0ce4218292aba42a4
4f7a4aec649eb10a42d21deb6aa62f68
0bfa32d587469ac3ef50aec3f985ebce
1a97eb949cf4c33783e387db54b833b1
8e1f3e30ac8462d6751f689a7bb5c82f
d10422232e0c65aa439c8f2a92853b9d
1356d458467d90fd7c001bfbd29fdb7d
1caf351c8bd83dc957f63eb70aaf7abd
-----END OpenVPN Static key V1-----
" >> /etc/openvpn/ta.key
mkdir /etc/openvpn/script
cp config.sh /etc/openvpn/script/
cp test_connect_db.sh /etc/openvpn/script/
cp login.sh /etc/openvpn/script/
cp connect.sh /etc/openvpn/script/
cp disconnect.sh /etc/openvpn/script/
chmod -R 755 /etc/openvpn
echo "net.ipv4.ip_forward=1" >> /etc/sysctl.conf
sysctl -p
semanage port -a -t openvpn_port_t -p udp 443
systemctl start openvpn@server
systemctl restart openvpn@server
systemctl enable openvpn@server
systemctl status openvpn@server
ip addr show tun0