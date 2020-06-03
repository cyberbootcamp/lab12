REPO = ${REMOTEHOST}

.PHONY: azurecli
azurecli: mkdirs
	which az || bin/setup_az.sh
	az --version

.PHONY: terraform
terraform: mkdirs
	which terraform || bin/setup_tf.sh
	#ls ${TF_file} && bin/setup_tf.sh
	terraform version

.PHONY: az_login
az_login: mkdirs
	az login | tee /home/kali/.uci/az/login

.PHONY: account_list
account_list: mkdirs
	az account list --query "[].{name:name, subscriptionId:id, tenantId:tenantId}" | tee ${HOME}/.uci/az/account_list

.PHONY: subscribe
subscribe: account_list
	bin/subscribe.sh
.PHONY: vars
vars: mkdirs
	bin/setvars.sh

#.PHONY: clean
#clean:  rm


# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#
#  Move or copy terraform config files into deployment directory.
#
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

# Make the temporary directories if they don't already exist.
.PHONY: mkdirs
mkdirs:
	ls ${HOME}/.uci/az || mkdir -p ${HOME}/.uci/az

# Copy the setup script from the repository to the deployment directory.
.PHONY: copy_setup
copy_setup: mkdirs
	cp RedTeam/setup.sh .

# Copy the vars file from the repostiroty to the deployment directory.
.PHONY: copy_vars
copy_vars: copy_setup
	cp RedTeam/*-vars.tf .

# Copy the main.tf from the repository to the deployment directory.
.PHONY: deploy_main
deploy_main: copy_vars
	cp RedTeam/main.tf .

# Copy the network 1 config file from the repository to the deployment directory.
.PHONY: deploy_network-1-1
deploy_network-1-1: deploy_main
	cp RedTeam/network-1.tf .

# Copy the network 1 overlay file from the repository to the deployment directory.
.PHONY: deploy_network-1-2
deploy_network-1-2: deploy_main
	cp RedTeam/network-1-overlay.tf ./network-1.tf

# Copy the network 2 files from the repository to the deployment directory.
.PHONY: deploy_subnet-webtier
deploy_subnet-webtier: deploy_network-1-2
	cp RedTeam/subnet-webtier.tf .

# Copy the red team security group config file from the repository to the deployment directory.
#.PHONY: copy_redteamsg
#copy_redteamsg: copy_network-1-2
#	cp ${REPO}/Week-12-Cloud-Security/Resources/terraform/RedTeam/RedTeam-SG.tf ~/my_az_deployment/.

.PHONY: create_id_rsa
create_id_rsa: deploy_subnet-webtier
	ls ${HOME}/.ssh/id_rsa ${HOME}/.ssh/id_rsa.pub || ssh-keygen -f ${HOME}/.ssh/id_rsa

.PHONY: create_id_vm3
create_id_vm3: create_id_rsa
	ls ${HOME}/.ssh/id_vm3 ${HOME}/.ssh/id_vm3.pub || ssh-keygen -f ${HOME}/.ssh/id_vm3

# Copy the virtual machine 1 config files from the repository to the deployment directory.
.PHONY: deploy_vm-1
deploy_vm-1: create_id_vm3
	cp RedTeam/vm-1.tf .
	cp RedTeam/cloud-init-1.txt .
	#base64 ~/my_az_deployment/cloud-init-1.txt > cloud-init-1.b64

# Copy the virtual machine 1 config files from the repository to the deployment directory.
.PHONY: deploy_vm-2
deploy_vm-2: deploy_vm-1
	cp RedTeam/vm-2.tf .
	cp RedTeam/cloud-init-2.txt .
	#base64 ~/my_az_deployment/cloud-init-2.txt > cloud-init-2.b64

.PHONY: deploy_all
deploy_all:	copy_vm-2
	echo 'Now run make plan'

.PHONY: set_ip
set_ip:
	read -p 'ip ' TF_VAR_my_ip_address
	echo "export TF_VAR_my_ip_address=${TF_VAR_my_ip_address}" > .config/TF_VAR_my_ip_address

.PHONY: deploy_ansible_key
deploy_ansible_key:
	scp ~/.ssh/id_vm2 ${jumpbox_ip}:.ssh/id_rsa

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#
#  terraform commands
#
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

# Initialize terraform config.
.PHONY: init
init:
	. ./setup.sh ; terraform init

# Run the terraform plan.
.PHONY: plan
plan:
	. ./setup.sh ; terraform plan --out "plan.out"

# Run a terraform plan to destroy the environment.
.PHONY: destroy
destroy:
	. ./setup.sh ; terraform plan -destroy --out "plan.out"

# Apply the terraform plan to build or destroy resources.
.PHONY: apply
apply:
	. ./setup.sh ; terraform apply "plan.out"

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#
#  The following is used by Korben to sync the local repo to the server where
#  the virtual machines are running.  It synchronizes only the changed files.
#
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

# Apply the terraform plan to build or destroy resources.
.PHONY: sync_repo
sync_repo:
	rsync -zavh ~/repositories/ lab01:repositories

.PHONY: refresh
refresh:
	clear ; curl ${REMOTEHOST}setup.sh | bash