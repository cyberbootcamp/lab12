#!/bin/bash

cd ${HOME}/docker
chmod -R 0777 ${HOME}/docker

until [[ $(which make) ]]
do
  echo waiting for make
  sleep 3
done

sleep 3
export container_name="ansible"
[[ $(sudo docker ps -f "name=${container_name}" --format '{{.Names}}') == ${container_name} ]] || make start
sudo docker exec ansible /bin/bash -c "ansible-playbook webserver/site.yml"