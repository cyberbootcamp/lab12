# lab12
Lab 12 - Lab Environment in Azure

## Installation
 ```
clear ; curl -fsSL -H 'Cache-Control: no-cache' https://lab12.raw.kirscht.com/setup.sh?_=$(date +%s) | bash
```

## Tools

If the Azure CLI or Terraform are not installed, run the following to install those tools.

```aidl
make azurecli

make terraform
```
## Login

If this is the first time deploying in this environment, you must run the login and subscribe.

```aidl
make az_login

make subscribe
```

## Deploying the Full Stack

```aidl
make deploy_all

make plan

make apply
```

## Destroy the Deployment

```aidl
make destroy

make apply
```