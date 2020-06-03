#!/bin/env bash
export LABDIR="${HOME}/my_az_lab/"
export REMOTEHOST="http://localhost:8080/lab12/"
export REMOTEHOST="https://raw.githubusercontent.com/cyberbootcamp/lab12/master/"

mkdir -p ${LABDIR}/{.config,bin,RedTeam}


setup_repo_path () {
  echo "setup_repo_path"
}

copy_file () {
  #curl -o ${2:-.}/${1} http://localhost:8080/lab12/${2:-.}/${1}
  curl -o ${LABDIR}/${2:-.}/${1} ${REMOTEHOST}${2:-.}/${1}
  chmod ${3} ${LABDIR}/${2:-.}/${1}
}

setup_repo_path

copy_file setup_az.sh bin '0555'
copy_file setup_tf.sh bin '0555'
copy_file setvars.sh bin '0555'
copy_file subscribe.sh bin '0555'

copy_file RedTeam-SG.tf RedTeam '0644'
copy_file RedTeam-vars.tf RedTeam '0644'
copy_file cloud-init-1.txt RedTeam '0644'
copy_file cloud-init-2.txt RedTeam '0644'
copy_file main.tf RedTeam '0644'
copy_file network-1-overlay.tf RedTeam '0644'
copy_file network-1.tf RedTeam '0644'
copy_file output.tf RedTeam '0644'
copy_file setup.sh RedTeam '0644'
copy_file subnet-webtier.tf RedTeam '0644'
copy_file vm-1.tf RedTeam '0644'
copy_file vm-2.tf RedTeam '0644'

copy_file Makefile . '0644'

#curl -o ${LABDIR}/bin/setup_az.sh http://localhost:8080/lab12/bin/setup_az.sh