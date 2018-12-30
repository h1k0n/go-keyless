mkdir CA && cd $_
openssl genrsa -out cakey.pem 2048
openssl req -new -key cakey.pem -out ca.csr -subj "/C=CN/ST=myprovince/L=mycity/O=myorganization/OU=mygroup/CN=myCA"
openssl x509 -req -days 365 -sha1 -extensions v3_ca -signkey cakey.pem -in ca.csr -out  cacert.pem

## for keyServer
cd ..
mkdir server-cert && cd $_
echo -e "[v3_req]\nsubjectAltName = IP:127.0.0.1" > extfile.cnf
openssl genrsa -out key.pem 2048
openssl req -new -key key.pem -out server.csr -subj "/C=CN/ST=myprovince/L=mycity/O=myorganization/OU=mygroup/CN=myServer"
openssl x509 -req -days 365 -sha1 -extensions v3_req -CA ../CA/cacert.pem -CAkey ../CA/cakey.pem -CAserial ca.srl -CAcreateserial -in server.csr -out cert.pem -extfile extfile.cnf
openssl verify -CAfile ../CA/cacert.pem  cert.pem

## for keylessProxy
cd ..
mkdir client-cert && cd $_
echo -e "[v3_req]\nsubjectAltName = IP:127.0.0.1" > extfile.cnf
openssl genrsa  -out key.pem 2048
openssl req -new -key key.pem -out client.csr -subj "/C=CN/ST=myprovince/L=mycity/O=myorganization/OU=mygroup/CN=myClient"
openssl x509 -req -days 365 -sha1 -extensions v3_req -CA  ../CA/cacert.pem -CAkey ../CA/cakey.pem  -CAserial ../server-cert/ca.srl -in client.csr -out cert.pem -extfile extfile.cnf
openssl verify -CAfile ../CA/cacert.pem  cert.pem


## for website
openssl req -newkey rsa:2048 \
  -new -nodes -x509 \
  -days 3650 \
  -out cert.pem \
  -keyout key.pem \
  -subj "/C=US/ST=California/L=Mountain View/O=Your Organization/OU=Your Unit/CN=test.xxx.com"
