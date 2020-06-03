#!/bin/bash
echo "Setting up Terraform"

TF_version="0.12.26"
TF_file="terraform_${TF_version}_linux_amd64.zip"
TF_url="https://releases.hashicorp.com/terraform/${TF_version}/${TF_file}"

ls /tmp/${TF_file} || curl -o /tmp/${TF_file} ${TF_url}

which terraform || zcat /tmp/${TF_file} >> /tmp/terraform && sudo mv /tmp/terraform /usr/local/bin/. \
&& chmod a+x /usr/local/bin/terraform
