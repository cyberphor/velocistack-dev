# Dockerfile metadata
FROM alpine:latest

# Install uwsgi
RUN apk add --no-cache python3 uwsgi-python3

# Copy configuration files
WORKDIR /etc/uwsgi/
COPY . .

RUN mkdir /opt/intel_owl/ &&\
    touch /opt/intel_owl/intel_owl.log

# Run uswgi
# https://greut.medium.com/minimal-python-deployment-on-docker-with-uwsgi-bc5aa89b3d35
# https://uwsgi-docs.readthedocs.io/en/latest/Configuration.html
CMD [ "uwsgi", "--ini", "/etc/uwsgi/sites/intel_owl.ini" ]