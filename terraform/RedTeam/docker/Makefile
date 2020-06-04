.PHONY: build
build:
	sudo docker build -t ansible .

.PHONY: start
start:
	sudo docker run -it -d --mount src="$(pwd)",target=/test_container,type=bind --name ansible ansible

.PHONY: connect
	sudo docker exec -i -t ansible /bin/bash