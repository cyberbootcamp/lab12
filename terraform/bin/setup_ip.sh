#!/usr/bin/env bash

curl 'https://api.ipify.org?format=json' | jq -r '.ip' | tee ./.config/my_ip_address
