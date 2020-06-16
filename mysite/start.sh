#!/bin/sh
python manage.py migrate
uwsgi --ini /home/docker/code/uwsgi.ini --http :8800
exec "$@"
