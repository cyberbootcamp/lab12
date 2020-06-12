#!/bin/env bash

export LABDIR="${HOME}/my_az_deployment_dev/"
export REMOTEHOST="http://localhost:8080/lab12/"
export REMOTEHOST=" -fsSL https://lab12.raw.kirscht.com/"
export REMOTEHOST=" -fsSL https://raw.githubusercontent.com/cyberbootcamp/lab12/korben/"
export REMOTEHOST="http://192.168.1.69:8080/lab12/"
export CONFIGDIR=${LABDIR}/.config

mkdir -p ${CONFIGDIR}

curl  -o ${LABDIR}/.config/getvars ${REMOTEHOST}/.config/getvars

echo "${LABDIR}" > ${CONFIGDIR}/LABDIR
echo "${REMOTEHOST}" > ${CONFIGDIR}/REMOTEHOST
chmod u+x ${CONFIGDIR}/{LABDIR,REMOTEHOST}

ls -l ${LABDIR}/site.yml && rm ${LABDIR}/site.yml
curl  -o ${LABDIR}/site.yml ${REMOTEHOST}site.yml

which ansible || sudo apt-get install -y ansible jq

echo "localhost connection=local" > ${LABDIR}/ansible_inventory
cd ${LABDIR} && ansible-playbook --inventory ./ansible_inventory -K ./site.yml

