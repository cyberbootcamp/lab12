# lab12
Lab 12 - Lab Environment in Azure

## Installation
 ```
clear ; curl -fsSL -H 'Cache-Control: no-cache' https://lab12.raw.kirscht.com/setup.sh?_=$(date +%s) | bash
```

```ff
clear ; curl -fsSL -H 'Cache-Control: no-cache' https://raw.githubusercontent.com/cyberbootcamp/lab12/korben/setup.sh | bash
```

```fff
clear ; curl -fsSL -H 'Cache-Control: no-cache' http://192.168.1.69:8080/lab12/setup.sh | bash
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