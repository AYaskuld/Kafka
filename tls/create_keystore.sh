# create key store
keytool -importkeystore \
    -deststorepass confluent \
    -destkeystore ./kafka/kafka.keystore.pkcs12 \
    -srckeystore ./kafka/kafka.p12 \
    -deststoretype PKCS12  \
    -srcstoretype PKCS12 \
    -noprompt \
    -srcstorepass confluent


# check
keytool -list -v \
    -keystore ./kafka/kafka.keystore.pkcs12 \
    -storepass confluent


# Save creds
echo "confluent" > ./kafka/kafka_sslkey_creds
echo "confluent" > ./kafka/kafka_keystore_creds
