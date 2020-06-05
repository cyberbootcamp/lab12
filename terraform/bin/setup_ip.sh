#!/usr/bin/env bash

{
	echo -n 'enter your ip address from https://whatismyipaddress.com/'
	read
	echo export TF_VAR_my_ip_address=${REPLY} | tee .config/TF_VAR_my_ip_address
}
chmod +x .config/TF_VAR_my_ip_address