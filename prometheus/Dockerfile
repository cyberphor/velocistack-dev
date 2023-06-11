# Dockerfile metadata
FROM prom/prometheus
LABEL maintainer="Wes Lambert, @therealwlambert"
LABEL contributor="Victor Fernandez III, @cyberphor"

# Copy Prometheus configuration file
COPY prometheus.yml /etc/prometheus/prometheus.yml

#CMD [ "prometheus", 
#        "--config.file=/etc/prometheus/prometheus.yml", 
#        "--web.external-url=http://0.0.0.0/velocistack/prometheus", 
#        "--web.route-prefix=/" 
#    ]