export TF_VAR_resource_group_name=Red-Team
export TF_VAR_location="westus2"

#export TF_VAR_machine1_size="Standard_B1ls"
export TF_VAR_machine1_size="Standard_B1s"
export TF_VAR_machine1_name="Jump-Box-Provisioner"
export TF_VAR_machine1_osdisk_type="Premium_LRS"
export TF_VAR_machine1_adminusername="RedAdmin"
export TF_VAR_machine1_publickey="$(cat ${HOME}/.ssh/id_rsa.pub)"
export TF_VAR_machine1_custom_data="$(base64 cloud-init.txt)"

#export TF_VAR_machine2_size="Standard_B1ls"
export TF_VAR_machine2_size="Standard_B1s"
export TF_VAR_machine2_name="DVWA-VM1"
export TF_VAR_machine2_osdisk_type="Premium_LRS"
export TF_VAR_machine2_adminusername="RedAdmin"
export TF_VAR_machine2_publickey="$(cat ${HOME}/.ssh/id_vm2.pub)"
export TF_VAR_machine2_custom_data="$(base64 cloud-init.txt)"