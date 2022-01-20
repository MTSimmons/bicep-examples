param Location string = 'eastus'

@description('Name of the storageaccont')
@maxLength(10)
param Name string = 'sitetest${uniqueString(resourceGroup().name)}'

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


