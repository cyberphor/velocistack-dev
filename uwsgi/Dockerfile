# Docker metadata
FROM python:3.9

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
RUN find /opt/intel_owl/requirements/ -name "*-requirements.txt" -type f -exec pip install -r '{}' ';'
RUN pip install boto3 psycopg2 prettyjson django_celery_results django_elasticsearch_dsl rest_email_auth

# Do stuff with Django
RUN python manage.py makemigrations rest_email_auth
RUN python manage.py migrate
RUN python manage.py createcachetable
RUN python manage.py collectstatic --noinput

# - postgres
# - uwsgi
#   - Run uswgi
#     - https://greut.medium.com/minimal-python-deployment-on-docker-with-uwsgi-bc5aa89b3d35
#     - https://uwsgi-docs.readthedocs.io/en/latest/Configuration.html
# - nginx
# - celery_beat
# - celery_worker
# - rabbitmq

# start the app (http://localhost)
CMD [ "uwsgi", "--ini", "/etc/uwsgi/sites/intel_owl.ini" ]

# create a super user