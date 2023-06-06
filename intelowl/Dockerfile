# Dockerfile metadata
FROM intelowlproject/intelowl:v4.0.0
LABEL Author="Victor Fernandez III, @cyberphor"

COPY entrypoint.sh /opt/deploy/intel_owl/entrypoint.sh
COPY configuration /opt/deploy/intel_owl/configuration/
COPY intel_owl.ini /etc/uwsgi/sites/intel_owl.ini

RUN touch /var/log/intel_owl/uwsgi/intel_owl.log

# Run uWSGI
CMD [ "/opt/deploy/intel_owl/entrypoint.sh" ]