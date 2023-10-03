#!/bin/bash

# create ca

openssl req -new -nodes \
   -x509 \
   -days 365 \
   -newkey rsa:2048 \
   -keyout ./ca/ca.key \
   -out ./ca/ca.crt \
   -config ./ca/ca.cnf

# transform to pen

cat ./ca/ca.crt ./ca/ca.key > ./ca/ca.pem

# create .crt .key

openssl req -new \
    -newkey rsa:2048 \
    -keyout ./kafka/kafka.key \
    -out ./kafka/kafka.csr \
    -config ./kafka/kafka.cnf \
    -nodes

# sign cert

openssl x509 -req \
    -days 3650 \
    -in ./kafka/kafka.csr \
    -CA ./ca/ca.crt \
    -CAkey ./ca/ca.key \
    -CAcreateserial \
    -out ./kafka/kafka.crt \
    -extfile ./kafka/kafka.cnf \
    -extensions v3_req

# export pkcs12

openssl pkcs12 -export \
    -in ./kafka/kafka.crt \
    -inkey ./kafka/kafka.key \
    -chain \
    -CAfile ./ca/ca.pem \
    -name kafka \
    -out ./kafka/kafka.p12 \
    -password pass:confluent
