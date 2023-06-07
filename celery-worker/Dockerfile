# Docker meta data
FROM intelowlproject/intelowl:v4.0.0
LABEL Author="Victor Fernandez III, @cyberphor"

# Copy Celery worker entrypoint
COPY . . 

# Run Celery worker
CMD [ "/opt/deploy/intel_owl/entrypoint.sh" ]