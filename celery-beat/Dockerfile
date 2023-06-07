# Docker meta data
FROM intelowlproject/intelowl:v4.0.0
LABEL Author="Victor Fernandez III, @cyberphor"

# Copy Celery beat entrypoint
COPY . . 

# Run Celery beat
CMD [ "/opt/deploy/intel_owl/entrypoint.sh" ]