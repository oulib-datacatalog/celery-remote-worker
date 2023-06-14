include config.env
include $(CYBERCOMMONS_PATH)/dc_config/secrets.env

export RABBITMQ_DEFAULT_USER
export RABBITMQ_DEFAULT_PASS
export RABBITMQ_DEFAULT_VHOST
export MONGO_USERNAME
export MONGO_PASSWORD
export MONGO_DB

SHELL := /bin/bash

venv:
	python -m venv venv
	source venv/bin/activate && pip install -r requirements.txt

ssl:
	mkdir -p ssl
	cp $(CYBERCOMMONS_PATH)/dc_config/ssl/backend/client/cert.pem ssl/.
	cp $(CYBERCOMMONS_PATH)/dc_config/ssl/backend/client/key.pem ssl/.
	cp $(CYBERCOMMONS_PATH)/dc_config/ssl/backend/client/mongodb.pem ssl/.
	cp $(CYBERCOMMONS_PATH)/dc_config/ssl/backend/testca/cacert.pem ssl/.

$(GIT_REPO_NAME):
	git submodule add --force -b $(GIT_REPO_BRANCH) $(GIT_REPO_URL)
	git submodule foreach git pull origin $(GIT_REPO_BRANCH)

.PHONY: init
init: venv ssl $(GIT_REPO_NAME)
	mkdir /tmp/remote_bagit_src
	mkdir /tmp/remote_bagit_src/preservation
	mkdir /tmp/remote_bagit_src/private
	mkdir /tmp/remote_bagit_src/shareok
	mkdir /tmp/local_bagit_src
	mkdir /tmp/local_bagit_src/preservation
	mkdir /tmp/local_bagit_src/private
	mkdir /tmp/local_bagit_src/shareok
	mkdir /tmp/remote_bagit_dest
	mkdir /tmp/remote_bagit_dest/preservation
	mkdir /tmp/remote_bagit_dest/private
	mkdir /tmp/remote_bagit_dest/shareok

.PHONY: run
run:
	source venv/bin/activate && ./startCeleryWorker	

.PHONY: clean
clean:
	rm -rf ssl
	rm -rf venv
	rm -rf __pycache__
	rm -rf /tmp/remote_bagit_src
	rm -rf /tmp/local_bagit_src 
	rm -rf /tmp/remote_bagit_dest
	git rm -f $(GIT_REPO_NAME)
	git rm -f .gitmodules

.PHONY: shell
shell:
	$$SHELL && source venv/bin/activate
