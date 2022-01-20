param Location string = 'eastus'

@description('Name of the storageaccont')
@maxLength(10)
param Name string = 'sitetest${uniqueString(resourceGroup().name)}'

param Identity string 

var saName = '${toLower(Name)}${uniqueString(resourceGroup().name)}'

resource storageaccount 'Microsoft.Storage/storageAccounts@2021-02-01' = {
  name: saName
  location: Location
  kind: 'StorageV2'
  sku: {
    name: 'Standard_LRS'
  }
  properties: {
    allowBlobPublicAccess: true
  }
}

resource deploymentScript 'Microsoft.Resources/deploymentScripts@2020-10-01' = {
  kind: 'AzurePowerShell'
  location: 'eastus'
  name: 'configure-testsite'
  identity: {
    type: 'UserAssigned'
    userAssignedIdentities: {
      '${Identity}': {}
    }
  }
  properties: {
    azPowerShellVersion: '6.4'
    retentionInterval: 'P1D'
    scriptContent: '''
    param (
      $IndexDocument,
      $ErrorDocument,
      $ResourceGroupName,
      $AccountName
      )
      
    $storageAccount = Get-AzStorageAccount -ResourceGroupName $ResourceGroupName -AccountName $AccountName
    $ctx = $storageAccount.Context
    Enable-AzStorageStaticWebsite -Context $ctx -IndexDocument $IndexDocument -ErrorDocument404Path $ErrorDocument
    '''
    arguments: '-IndexDocument "index.html" -ErrorDocument "404.html" -ResourceGroupName ${resourceGroup().name} -AccountName ${storageaccount.name}'
  }
}
