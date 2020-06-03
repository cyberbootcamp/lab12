#!/bin/bash

echo "Setting environment variables for Terraform"

service_file="${HOME}/.uci/az/service"
list_file="${HOME}/.uci/az/account_list"

export ARM_SUBSCRIPTION_ID="$(cat ${list_file} | jq -r '.[].subscriptionId')"
export ARM_CLIENT_ID="$(cat ${service_file} | jq -r '.appId')"
export ARM_CLIENT_SECRET="$(cat ${service_file} | jq -r '.password')"
export ARM_TENANT_ID="$(cat ${service_file} | jq -r '.tenant')"
# Not needed for public, required for usgovernment, german, china export ARM_ENVIRONMENT=public
export ARM_ENVIRONMENT=public

cat <<_EOD_

Variables:

ARM_SUBSCRIPTION_ID = ${ARM_SUBSCRIPTION_ID}
ARM_CLIENT_ID = ${ARM_CLIENT_ID}
ARM_CLIENT_SECRET = ${ARM_CLIENT_SECRET}
ARM_TENANT_ID = ${ARM_TENANT_ID}

_EOD_