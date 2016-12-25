#!/bin/bash
#
# SSLの自己証明書を作成する
#
cd /etc/nginx/conf.d/

pass="password"
domain=$1
key="${domain}.key"
csr="${domain}.csr"
crt="${domain}.crt"

# 秘密鍵の生成
expect -c "
  set timeout 5
  spawn openssl genrsa -out ${key} -aes256 2048
  expect \"Enter pass phrase for ${key}:\"
  send \"${pass}\n\"
  expect \"Verifying - Enter pass phrase for ${key}:\"
  send \"${pass}\n\"
  expect eof
  exit
"

# 公開鍵の作成
expect -c "
  set timeout 5
  spawn openssl req -new -key ${key} -out ${csr}
  expect \"Enter pass phrase for ${key}:\"
  send \"${pass}\n\"
  expect \"Country Name\"
  send \"JP\n\"
  expect \"State or Province Name\"
  send \"Tokyo\n\"
  expect \"Locality Name\"
  send \"Tokyo-to,Shinjyku-ku\n\"
  expect \"Organization Name\"
  send \"stylagy inc.\n\"
  expect \"Organizational Unit Name\"
  send \"stylagy\n\"
  expect \"Common Name\"
  send \"${domain}\n\"
  expect \"Email Address\"
  send \"\n\"
  expect \"A challenge password\"
  send \"\n\"
  expect \"An optional company name\"
  send \"\n\"
  expect eof
  exit
"

# デジタル証明書の作成
expect -c "
  set timeout 5
  spawn openssl x509 -in ${csr} -days 3650 -req -signkey ${key} -out ${crt}
  expect \"Enter pass phrase for ${key}:\"
  send \"${pass}\n\"
  expect eof
  exit
"

# 起動時にパスフレーズの入力を省略させる
expect -c "
  set timeout 5
  spawn openssl rsa -in ${key} -out ${key}
  expect \"Enter pass phrase for ${key}:\"
  send \"${pass}\n\"
  expect eof
  exit
"

exit 0
