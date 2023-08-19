# Dockerfile metadata
FROM intelowlproject/intelowl:v4.0.0
LABEL maintainer="Wes Lambert, @therealwlambert"
LABEL contributor="Victor Fernandez III, @cyberphor"

COPY entrypoint.sh /opt/deploy/intel_owl/entrypoint.sh
COPY configuration /opt/deploy/intel_owl/configuration/
COPY intel_owl.ini /etc/uwsgi/sites/intel_owl.ini
COPY urls.py /opt/deploy/intel_owl/intel_owl/urls.py

RUN touch /var/log/intel_owl/uwsgi/intel_owl.log

# Run uWSGI
CMD [ "/opt/deploy/intel_owl/entrypoint.sh" ]