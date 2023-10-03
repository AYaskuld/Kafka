#!/bin/bash
# Create trust store
keytool -keystore ./path/to/kafka.client.truststore.pkcs12 \
    -alias CARoot \
    -import \
    -file ./ca/ca.crt \
    -storepass confluent  \
    -noprompt \
    -storetype PKCS12
