[CmdletBinding()]
param (
$IndexDocument,
$ErrorDocument,
$ResourceGroupName,
$AccountName
)

$storageAccount = Get-AzStorageAccount -ResourceGroupName $ResourceGroupName -AccountName $AccountName
$ctx = $storageAccount.Context
Enable-AzStorageStaticWebsite -Context $ctx -IndexDocument <index-document-name> -ErrorDocument404Path <error-document-name>
