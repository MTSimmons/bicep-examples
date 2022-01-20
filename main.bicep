targetScope = 'subscription'

param StartDate string = utcNow('yyyy-MM-dd-HH-mm-ss')
param Location string = 'eastus'

@maxLength(10)
param ProjectName string

resource netRg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: '${ProjectName}-net-rg'
  location: Location
}

resource appRg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: '${ProjectName}-app-rg'
  location: Location
}

resource monitorRg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: '${ProjectName}-monitor-rg'
  location: Location
}

module net './modules/network/network.bicep' = {
  name: '${ProjectName}-vnet-${StartDate}'
  scope: netRg
  params: {
    Name: '${ProjectName}-vnet'
  }
}

module storage 'modules/storage/storage.bicep' = {
  name: '${ProjectName}-storage-${StartDate}'
  scope: appRg 
  params: {
    Location: appRg.location
    Name: ProjectName
  }
}
