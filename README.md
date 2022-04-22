Cybercommons Remote Celery Worker 
=======

The Cybercommons framework is a Django Rest Framework API. The API leverages MongoDB to provide a Catalog and Data Store for storing metadata and data within a JSON document database. The API also includes Celery which is an asynchronous task queue/jobs based on distributed message passing.

This project is intended to assist with creating a local development and testing environment of Celery tasks for cyberCommons.


## Requirements

* Python 3.7+
* GNU Make or equivalent

## Setup
1. Edit config.env
   * Point `CYBERCOMMONS_PATH` to your local cybercommons' root path. This is used to pull in secrets.
   * Edit `GIT_REPO_NAME`, `GIT_REPO_URL`, and `GIT_REPO_BRANCH` to point to your desired task code.
   * Edit `CELERY_IMPORTS` to match the module name of your desired task code. This will match the name in the setup.py file from the task module pointed to by `GIT_REPO_URL`.
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
* Update variable in celeryconfig.py
