#!/bin/env bash
export LABDIR="${HOME}/my_az_lab/"
export REMOTEHOST="http://localhost:8080/lab12/"
export REMOTEHOST="https://raw.githubusercontent.com/cyberbootcamp/lab12/master/terraform/"

mkdir -p ${LABDIR}/{.config,bin,RedTeam}

which ansible || sudo apt-get install -y ansible
ansible-playbook --connection=local --inventory 127.0.0.1 -K ./site.yml

