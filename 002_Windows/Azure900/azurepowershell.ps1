# Powershell commando's voor Azure beheer

## Create a rescource group

```powershell
az group create --name IntroAzureRG --location norwayeast
```

## Create a virtual machine

```powershell
az vm create --resource-group "IntroAzureRG" --name azuretest --size Standard_B2as_v2 --public-ip-sku Standard --image Ubuntu2204 --admin-username azureuser --generate-ssh-keys
```

## Install extension (Nginx webserver)

```powershell
az vm extension set --resource-group "IntroAzureRG" --vm-name azuretest --name customScript --publisher Microsoft.Azure.Extensions --version 2.1 --settings '{"fileUris":["https://raw.githubusercontent.com/MicrosoftDocs/mslearn-welcome-to-azure/master/configure-nginx.sh"]}' --protected-settings '{"commandToExecute": "./configure-nginx.sh"}'
```


## List network security groups and rules

```powershell
az network nsg list --resource-group "IntroAzureRG" --query '[].name' --output tsv
az network nsg rule list --resource-group "IntroAzureRG" --nsg-name Azu
az network nsg rule list --resource-group "IntroAzureRG" --nsg-name AzuretestNSG --query '[].{Name:name, Priority:priority, Port:destinationPortRange, Access:access}' --output table
```

## Network security rule aanmaken

```powershell
az network nsg rule create --resource-group "IntroAzureRG" --nsg-name azuretestNSG --name allow-test --protocol tcp --priority 100 --destination-port-range 4480 --access Allow
```

## Network security rules bekijken

```powershell
az network nsg rule list --resource-group "IntroAzureRG" --nsg-name azuretestNSG --query '[].{Name:name, Priority:priority, Port:destinationPortRange, Access:access}' --output table
```

