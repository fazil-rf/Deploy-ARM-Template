# Login to Azure using Service Principal credentials from Github Secrets
Write-Output "Logging in to Azure with a service principal..."
az login `
    --service-principal `
    --username $Env:SP_CLIENT_ID `
    --password $Env:SP_CLIENT_SECRET `
    --tenant $Env:SP_TENANT_ID
Write-Output "Done"

# Select Azure subscription
Select-AzSubscription `
    --SubscriptionId $Env:AZURE_SUBSCRIPTION_ID

# Create the VM configuration object
$ResourceGroupName = "RG-Infra-UpSkilling-July2022"
$VmName = "fazil-Demo-vm"

# Create a VM in Azure
Write-Output "Creating VM..."
try {
    az vm create  `
        --resource-group $ResourceGroupName `
        --name $VmName `
        --image win2016datacenter `
        --admin-password $Env:SP_CLIENT_SECRET `
    }
catch {
    Write-Output "VM already exists"
    }
Write-Output "Done creating VM"
