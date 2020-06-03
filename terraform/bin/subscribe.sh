#!/bin/bash

login_file="${HOME}/.uci/az/login"
list_file="${HOME}/.uci/az/account_list"
service_file="${HOME}/.uci/az/service"
ls ${login_file} || echo "login file ${login_file} does not exist"

az account list --query "[].{name:name, subscriptionId:id, tenantId:tenantId}" | tee ${list_file}

SUBSCRIPTION_ID="$(cat ${list_file} | jq -r '.[].subscriptionId')"

echo ${SUBSCRIPTION_ID}
ls ${service_file} || az ad sp create-for-rbac --role="Contributor" --scopes="/subscriptions/${SUBSCRIPTION_ID}" | tee ${service_file}