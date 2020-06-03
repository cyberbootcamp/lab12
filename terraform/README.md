# Setting up Terraform for Azure on Kali
We are going to use our Kali machine to install the Terraform for Azure.   This is not something that you would typically want to do, nor is it advised in production.  But it gives us a common point with the resources that we already have at our disposal.

## Install - AzureCLI

```make azurecli```

## Install - Terraform

```make terraform```

## Azure Login

```make azurelogin```

## Azure Subscribe

```make subscribe```

### Deploy in Azure

1. #### Create the deployment directory.
```mkdir ${HOME}/my_az_deployment```

2. #### Change to the Deployment Directory
```cd ${HOME}/my_az_deployment```

2. #### Copy the first config file.
```cp <path-to-repository>/Week-12-Cloud-Security/Resources/terraform/main.tf .```

3. #### Initialize the Configuration
```terraform init```

4. #### Plan the Deployment
```terraform plan --out plan.out```

5. #### Apply the Plan
```terraform apply "plan.out"```

6. #### Show Configuration
```terraform show```

7. #### Copy the first network config file.
```cp <path-to-repository>/Week-12-Cloud-Security/Resources/terraform/network-1.tf .```

8. #### Plan the Deployment
```terraform plan --out plan.out```

9. #### Apply the Plan
```terraform apply "plan.out"```

10. #### Show Configuration
```terraform show```

11. #### Copy the first network config file.
```cp <path-to-repository>/Week-12-Cloud-Security/Resources/terraform/network-1-overlay.tf network-1.tf```

12. #### Plan the Deployment
```terraform plan --out plan.out```

13. #### Apply the Plan
```terraform apply "plan.out"```

14. #### Show Configuration
```terraform show```

15. #### Copy the first network config file.
```cp <path-to-repository>/Week-12-Cloud-Security/Resources/terraform/network-2.tf .```

16. #### Plan the Deployment
```terraform plan --out plan.out```

17. #### Apply the Plan
```terraform apply "plan.out"```

19. #### Show Configuration
```terraform show```

20. #### Generate SSH Key Pair

Make sure you don't already have a keypair

```ls ~/.ssh/id_rsa*```

```ssh-keygen```

```cat ~/.ssh/id_rsa.pub```

```cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys```

21. #### Copy the first network config file.
```cp <path-to-repository>/Week-12-Cloud-Security/Resources/terraform/network-2.tf .```

22. #### Plan the Deployment
```terraform plan --out plan.out```

23. #### Apply the Plan
```terraform apply "plan.out"```

24. #### Show Configuration
```terraform show```

25. #### Generate SSH Key Pair
```ssh-keygen```

cat ~/.ssh/id_rsa.pub

cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
>>>>>>> master
=======
>>>>>>> 07a1df476f8823e437dac7fbc5ea1f09ddbaa810


# References
[Quickstart: Install and configure Terraform to provision Azure resources](https://docs.microsoft.com/en-us/azure/developer/terraform/install-configure)

[Azure Provider: Authenticating using the Azure CLI](https://www.terraform.io/docs/providers/azurerm/guides/azure_cli.html)

[What is the purpose of .PHONY in a makefile?](https://stackoverflow.com/questions/2145590/what-is-the-purpose-of-phony-in-a-makefile)

[Download Terraform](https://www.terraform.io/downloads.html)

[Install Azure CLI with apt](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli-apt?view=azure-cli-latest)

[HashiCorp Terraform on Azure](https://azure.microsoft.com/en-us/solutions/devops/terraform/#overview)


Command to remote sync repo:

rsync -zavh ~/repositories/ korben@lab01:repositories

Error: Error creating Linux Virtual Machine "RedTeamVM-1" (Resource Group "Red-Team"): compute.VirtualMachinesClient#CreateOrUpdate: Failure sending request: StatusCode=400 -- Original Error: Code="InvalidParameter" Message="The requested VM size Standard_B1 is not available in the current region. The sizes available in the current region are: Standard_B1ls,Standard_B1ms,Standard_B1s,Standard_B2ms,Standard_B2s,Standard_B4ms,Standard_B8ms,Standard_B12ms,Standard_B16ms,Standard_B20ms,Standard_DS1_v2,Standard_DS2_v2,Standard_DS3_v2,Standard_DS4_v2,Standard_DS5_v2,Standard_DS11-1_v2,Standard_DS11_v2,Standard_DS12-1_v2,Standard_DS12-2_v2,Standard_DS12_v2,Standard_DS13-2_v2,Standard_DS13-4_v2,Standard_DS13_v2,Standard_DS14-4_v2,Standard_DS14-8_v2,Standard_DS14_v2,Standard_DS15_v2,Standard_DS2_v2_Promo,Standard_DS3_v2_Promo,Standard_DS4_v2_Promo,Standard_DS5_v2_Promo,Standard_DS11_v2_Promo,Standard_DS12_v2_Promo,Standard_DS13_v2_Promo,Standard_DS14_v2_Promo,Standard_F1s,Standard_F2s,Standard_F4s,Standard_F8s,Standard_F16s,Standard_D2s_v3,Standard_D4s_v3,Standard_D8s_v3,Standard_D16s_v3,Standard_D32s_v3,Standard_A0,Standard_A1,Standard_A2,Standard_A3,Standard_A5,Standard_A4,Standard_A6,Standard_A7,Basic_A0,Basic_A1,Basic_A2,Basic_A3,Basic_A4,Standard_D1_v2,Standard_D2_v2,Standard_D3_v2,Standard_D4_v2,Standard_D5_v2,Standard_D11_v2,Standard_D12_v2,Standard_D13_v2,Standard_D14_v2,Standard_D15_v2,Standard_D2_v2_Promo,Standard_D3_v2_Promo,Standard_D4_v2_Promo,Standard_D5_v2_Promo,Standard_D11_v2_Promo,Standard_D12_v2_Promo,Standard_D13_v2_Promo,Standard_D14_v2_Promo,Standard_F1,Standard_F2,Standard_F4,Standard_F8,Standard_F16,Standard_A1_v2,Standard_A2m_v2,Standard_A2_v2,Standard_A4m_v2,Standard_A4_v2,Standard_A8m_v2,Standard_A8_v2,Standard_D2_v3,Standard_D4_v3,Standard_D8_v3,Standard_D16_v3,Standard_D32_v3,Standard_D1,Standard_D2,Standard_D3,Standard_D4,Standard_D11,Standard_D12,Standard_D13,Standard_D14,Standard_DS1,Standard_DS2,Standard_DS3,Standard_DS4,Standard_DS11,Standard_DS12,Standard_DS13,Standard_DS14,Standard_D48_v3,Standard_D64_v3,Standard_D48s_v3,Standard_D64s_v3,Standard_E2_v3,Standard_E4_v3,Standard_E8_v3,Standard_E16_v3,Standard_E20_v3,Standard_E32_v3,Standard_E48_v3,Standard_E64_v3,Standard_E2s_v3,Standard_E4-2s_v3,Standard_E4s_v3,Standard_E8-2s_v3,Standard_E8-4s_v3,Standard_E8s_v3,Standard_E16-4s_v3,Standard_E16-8s_v3,Standard_E16s_v3,Standard_E20s_v3,Standard_E32-8s_v3,Standard_E32-16s_v3,Standard_E32s_v3,Standard_E48s_v3,Standard_E64-16s_v3,Standard_E64-32s_v3,Standard_E64s_v3,Standard_L8s_v2,Standard_L16s_v2,Standard_L32s_v2,Standard_L48s_v2,Standard_L64s_v2,Standard_L80s_v2,Standard_E64i_v3,Standard_E64is_v3,Standard_G1,Standard_G2,Standard_G3,Standard_G4,Standard_G5,Standard_GS1,Standard_GS2,Standard_GS3,Standard_GS4,Standard_GS4-4,Standard_GS4-8,Standard_GS5,Standard_GS5-8,Standard_GS5-16,Standard_L4s,Standard_L8s,Standard_L16s,Standard_L32s,Standard_F2s_v2,Standard_F4s_v2,Standard_F8s_v2,Standard_F16s_v2,Standard_F32s_v2,Standard_F48s_v2,Standard_F64s_v2,Standard_F72s_v2,Standard_A8,Standard_A9,Standard_A10,Standard_A11,Standard_H8,Standard_H8_Promo,Standard_H16,Standard_H16_Promo,Standard_H8m,Standard_H8m_Promo,Standard_H16m,Standard_H16m_Promo,Standard_H16r,Standard_H16r_Promo,Standard_H16mr,Standard_H16mr_Promo,Standard_NV6s_v2,Standard_NV12s_v2,Standard_NV24s_v2,Standard_NV12s_v3,Standard_NV24s_v3,Standard_NV48s_v3.\r\nFind out more on the available VM sizes in each region at https://aka.ms/azure-regions." Target="vmSize"

  on vm-1.tf line 21, in resource "azurerm_linux_virtual_machine" "redteam-vm1":
  21: resource "azurerm_linux_virtual_machine" "redteam-vm1" {
  
  az vm list-skus --location southcentralus --size Standard_F --output table
  
  
