#!/bin/env bash

export LABDIR="${HOME}/my_az_deployment/"
export REMOTEHOST="http://localhost:8080/lab12/"
export REMOTEHOST=" -fsSL https://lab12.raw.kirscht.com/"

mkdir -p ${LABDIR}/{.config,bin,RedTeam}

[[ -e ${LABDIR}/site.yml ]] && rm ${LABDIR}/site.yml

curl  -o ${LABDIR}/site.yml ${REMOTEHOST}site.yml?_=$(date +%s)

echo "localhost" > ${LABDIR}/ansible_inventory

which ansible || sudo apt-get install -y ansible

(cd ${LABDIR} && /usr/bin/ansible-playbook --connection=local --inventory ${LABDIR}/ansible_inventory -K ./site.yml)

