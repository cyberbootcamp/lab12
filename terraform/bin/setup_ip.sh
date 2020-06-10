#!/usr/bin/env bash

{
	#echo -n 'enter your ip address from https://whatismyipaddress.com/'
	#read
	export myip=$(curl 'https://api.ipify.org?format=json' | jq -r '.ip')
	echo export TF_VAR_my_ip_address=${myip} | tee .config/TF_VAR_my_ip_address
}
chmod +x .config/TF_VAR_my_ip_address