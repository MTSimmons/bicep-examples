param ProjectName string
param ResourceGroupList array

var storageConfigurations = [
  {
    suffix: 'local'
    sku: 'Standard_LRS'
  }
  {
    suffix: 'geo'
    sku: 'Standard_GRS'
  }
]

resource managedId 'Microsoft.ManagedIdentity/userAssignedIdentities@2018-11-30' = {
  location: 'eastus'
  name: '${ProjectName}-deploy'
}

resource roleAssignment 'Microsoft.Authorization/roleAssignments@2020-10-01-preview' =  [for (rg, i) in ResourceGroupList: {
  name: '${rg.suffix}-deploy-contributor'
  properties: {
    principalId: managedId.id
    roleDefinitionId: 'b24988ac-6180-42a0-ab88-20f7382dd24c'
    principalType: 'ServicePrincipal'
  }
}]

output ManagedId string = managedId.id
output ManagedIdName string = managedId.name

