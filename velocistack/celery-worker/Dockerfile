# Docker meta data
FROM intelowlproject/intelowl:v4.0.0
LABEL maintainer="Wes Lambert, @therealwlambert"
LABEL contributor="Victor Fernandez III, @cyberphor"

# Copy Celery worker entrypoint
COPY entrypoint.sh /opt/deploy/intel_owl/entrypoint.sh

# Run Celery worker
CMD [ "/opt/deploy/intel_owl/entrypoint.sh" ]