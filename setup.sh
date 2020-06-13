#!/bin/env bash

cat <<_EOT_

  Downloading and installing Azure Cloud environment for Red Team

_EOT_

#  Set the following REMOTEHOST variables to match the source location from
#  which the deployment is being made.
#export LABDIR="${HOME}/my_az_deployment_dev/"
export LABDIR="${HOME}/my_az_deployment/"
#export REMOTEHOST="http://localhost:8080/lab12/"
export REMOTEHOST="https://lab12.raw.kirscht.com/terraform/"
#export REMOTEHOST="https://raw.githubusercontent.com/cyberbootcamp/lab12/korben/terraform/"
#export REMOTEHOST="http://192.168.1.69:8080/lab12/"
export CONFIGDIR=${LABDIR}/.config

echo "Creating configuration directory ${CONFIGDIR}"
mkdir -p ${CONFIGDIR}
echo "Succeeded"


curl  -fsSL -o ${LABDIR}/.config/getvars ${REMOTEHOST}/.config/getvars

echo "${LABDIR}" > ${CONFIGDIR}/LABDIR
echo "${REMOTEHOST}" > ${CONFIGDIR}/REMOTEHOST
chmod u+x ${CONFIGDIR}/{LABDIR,REMOTEHOST}

echo "Pull site.yml from ${REMOTEHOST}"
ls -l ${LABDIR}/site.yml && rm ${LABDIR}/site.yml
curl  -fsSL -o ${LABDIR}/site.yml ${REMOTEHOST}/site.yml

echo "Install ansible and jq if not already installed."
which ansible || sudo apt-get install -y ansible jq

echo "Create dummy ansible inventory file."
echo "localhost connection=local" > ${LABDIR}/ansible_inventory

cat <<_EOT_

Running ansible playbook.

Enter your kali sudo password if prompted.

_EOT_


cd ${LABDIR} && ansible-playbook --inventory ./ansible_inventory -K ./site.yml

cat <<_EOT_

  Ansible playbook complete, continue with the next step.

  To continue working, change directory to the deployment directory.
  cd ${LABDIR}

  Most likely run 'make deploy_all' to deploy everything.

_EOT_

