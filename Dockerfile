# Docker metadata
FROM python:3.9.16

# Download Intel Owl 
WORKDIR /opt/intel_owl/
RUN git clone https://github.com/intelowlproject/IntelOwl . &&\
    mv docker/scripts/logrotate/ /etc/logrotate.d/ &&\
    mkdir /opt/intel_owl/logs/ &&\
    touch /opt/intel_owl/logs/intel_owl.log &&\
    mkdir /var/log/intel_owl/ &&\
    mkdir /var/log/intel_owl/django/ &&\
    touch /var/log/intel_owl/django/api_app.log

# Install uWSGI, Django, and other Python dependencies
COPY . .
RUN pip install -r /opt/intel_owl/requirements/certego-requirements.txt
RUN pip install -r /opt/intel_owl/requirements/django-server-requirements.txt
RUN pip install -r /opt/intel_owl/requirements/docs-requirements.txt
RUN pip install -r /opt/intel_owl/requirements/pre-requirements.txt
RUN pip install -r /opt/intel_owl/requirements/test-requirements.txt

# Do stuff with Django
#RUN python manage.py makemigrations durin
#RUN python manage.py makemigrations rest_email_auth
#RUN python manage.py migrate
#RUN python manage.py createcachetable
#RUN python manage.py collectstatic --noinput

# - postgres
# - uwsgi
#   - Run uswgi
#     - https://greut.medium.com/minimal-python-deployment-on-docker-with-uwsgi-bc5aa89b3d35
#     - https://uwsgi-docs.readthedocs.io/en/latest/Configuration.html
# - rabbitmq
# - celery_beat
# - celery_worker
# - nginx

# start the app (http://localhost)
CMD [ "uwsgi", "--ini", "/etc/uwsgi/sites/intel_owl.ini" ]

# create a super user