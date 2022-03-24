import os
import ssl
import logging

# Refer to Celery's configuration documentation for details on these settings.
# https://docs.celeryproject.org/en/stable/userguide/configuration.html

# SETUP BROOKER URI
RABBITMQ_DEFAULT_USER = os.environ.get('RABBITMQ_DEFAULT_USER')
RABBITMQ_DEFAULT_PASS = os.environ.get('RABBITMQ_DEFAULT_PASS')
RABBITMQ_DEFAULT_VHOST = os.environ.get('RABBITMQ_DEFAULT_VHOST')
broker_url = f"amqp://{RABBITMQ_DEFAULT_USER}:{RABBITMQ_DEFAULT_PASS}@localhost:5671/{RABBITMQ_DEFAULT_VHOST}"
broker_use_ssl = {
    'keyfile': 'ssl/key.pem',
    'certfile': 'ssl/cert.pem',
    'ca_certs': 'ssl/cacert.pem',
    'cert_reqs': ssl.CERT_REQUIRED
}
worker_send_task_events = True
result_expires = None
accept_content = ['json']

# SETUP MONGO URI
SSL_PATH = os.environ.get('SSL_PATH')
MONGO_USERNAME = os.environ.get('MONGO_USERNAME')
MONGO_PASSWORD = os.environ.get('MONGO_PASSWORD')
result_backend = f"mongodb://{MONGO_USERNAME}:{MONGO_PASSWORD}@localhost:27017/?ssl=true&ssl_ca_certs=ssl/cacert.pem&ssl_certfile=ssl/mongodb.pem" 

mongodb_backend_settings = {
    "database": os.environ.get('MONGO_DB', "cybercom"),
    "taskmeta_collection": os.environ.get('MONGO_TOMBSTONE_COLLECTION', "tombstone")
}
try:
    imports = tuple(os.environ.get('CELERY_IMPORTS').split(','))
except AttributeError:
    logging.error("CELERY_IMPORTS env variable not set! Try running from Makefile - make run")
