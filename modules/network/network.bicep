param Location string = 'eastus'

@description('Name of the network')
param Name string 




resource network 'Microsoft.Network/virtualNetworks@2019-11-01' = {
  name: Name
  location: Location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.20.0.0/16'
      ]
    }
    subnets: [
      {
        name: 'Subnet-0'
        properties: {
          addressPrefix: '10.20.0.0/24'
        }
      }
      {
        name: 'Subnet-1'
        properties: {
          addressPrefix: '10.20.1.0/24'
        }
      }
    ]
  }
}




output networkId string = network.id
output subnet0Id string = network.properties.subnets[0].id
output subnet1Id string = network.properties.subnets[1].id

