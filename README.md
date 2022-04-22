Cybercommons Remote Celery Worker 
=======

The Cybercommons framework is a Django Rest Framework API. The API leverages MongoDB to provide a Catalog and Data Store for storing metadata and data within a JSON document database. The API also includes Celery which is an asynchronous task queue/jobs based on distributed message passing.

This is an example Celery worker that can be used as a starting point for deploying a remote worker.

## Requirements

* Python 3.7+
* GNU Make or equivalent

## Setup
1. Edit config.env to point `CYBERCOMMONS_PATH` to local cybercommons' root path. This is used to pull in secrets.
1. Edit `CELERY_IMPORTS` and `CELERY_SOURCE` in config.env to point to desired github repository for task queue.
1. Initialize Python virtual environment and copy ssl certs from cybercommons.
    ```sh
    make init
    ```
1. With the cybercommons server running and ports 5671 and 27017 accessible, run the following to connect.
    ```sh
    make run
    ```
1. To stop Celery, use `CTRL+C`
1. Clean up / remove generated files
    ```sh
    make clean
    ```

## TODO
* Add cybercom.cfg file pointing to local dev host
