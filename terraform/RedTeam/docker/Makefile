.PHONY: waitfordocker
waitfordocker:
	./waitfordocker.sh

.PHONY: build
build: waitfordocker
	sudo docker build -t ansible .

.PHONY: start
start: build
	sudo docker run -it -d --mount src="${HOME}",target=/test_container,type=bind \
		--mount src="${HOME}/docker/etc",target=/etc/ansible,type=bind \
		--mount src="${HOME}/.ssh",target=/home/RedAdmin/.ssh,type=bind \
		--mount src="${HOME}/docker/webserver",target=/home/RedAdmin/webserver,type=bind \
		--mount src="${HOME}/docker/elasticsearch",target=/home/RedAdmin/elasticsearch,type=bind \
		--name ansible ansible

.PHONY: connect
connect:
	sudo docker exec -i -t ansible /bin/bash

.PHONY: install_files
install_files:
	sudo docker exec -i -t ansible /test_container/docker/update_ansible_cfg.sh

.PHONY: stop
stop:
	sudo docker stop ansible

.PHONY: rm
rm: stop
	sudo docker rm ansible

# 0644 ansible.cfg
# hosta
# dir 0755 roles