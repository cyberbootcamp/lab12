.PHONY: build
build:
	sudo docker build -t ansible .

.PHONY: start
start:
	sudo docker run -it -d --mount src="${HOME}",target=/test_container,type=bind --name ansible ansible

.PHONY: connect
connect:
	sudo docker exec -i -t ansible /bin/bash

.PHONY: install_files
install_files:
	sudo docker exec -i -t ansible /test_container/docker/update_ansible_cfg.sh