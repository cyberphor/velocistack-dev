# Dockerfile metadata
FROM kibana:8.7.1
LABEL maintainer="Wes Lambert, @therealwlambert"
LABEL contributor="Victor Fernandez III, @cyberphor"

# Copy Kibana configuration files
COPY kibana.yml config/kibana.yml
COPY setup-kibana.sh setup-kibana.sh

# Set the Kibana service account password and start Kibana
CMD curl -X POST https://172.16.0.10:9200/_security/user/kibana_system/_password \
      --cacert config/certs/ca.crt \
      -u "elastic:elasticsearch" \
      -H "Content-Type: application/json" \
      -d '{"password": "kibana"}' \
      -s &&\
    echo "Set Kibana password to 'kibana'" &&\
    /usr/local/bin/kibana-docker