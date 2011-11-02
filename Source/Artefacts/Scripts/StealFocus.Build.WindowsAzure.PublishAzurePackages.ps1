param
(
	[string]$subscriptionId = $(throw "subscriptionId is required"),
	[string]$managementCertificateThumbprint = $(throw "managementCertificateThumbprint is required"),
	[string]$affinityGroupName = $(throw "affinityGroupName is required"),
	[string]$affinityGroupLabel = $(throw "affinityGroupLabel is required"),
	[string]$affinityGroupLocation = $(throw "affinityGroupLocation is required"),
	[string]$hostedServiceName = $(throw "hostedServiceName is required"),
	[string]$hostedServiceLabel = $(throw "hostedServiceLabel is required"),
	[string]$storageAccountName = $(throw "storageAccountName is required"),
	[string]$storageAccountLabel = $(throw "storageAccountLabel is required"),
	[string]$packageFilePath = $(throw "packageFilePath is required"),
	[string]$configurationFilePath = $(throw "configurationFilePath is required"),
	[string]$deploymentLabel = $(throw "deploymentLabel is required"),
	[string]$removeStagingEnvironmentAfterwards = $(throw "removeStagingEnvironmentAfterwards is required"),
	[string]$promoteToProductionEnvironment = $(throw "promoteToProductionEnvironment is required")
)

[bool]$removeStagingEnvironmentAfterwardsValue = [System.Convert]::ToBoolean($removeStagingEnvironmentAfterwards)
[bool]$promoteToProductionEnvironmentValue = [System.Convert]::ToBoolean($promoteToProductionEnvironment)

Import-Module .\StealFocus.Build.WindowsAzure.psm1 -DisableNameChecking

$managementCertificate = Get-ManagementCertificate -managementCertificateThumbprint $managementCertificateThumbprint
$affinityGroup = Create-AffinityGroup -subscriptionId $subscriptionId -managementCertificate $managementCertificate -affinityGroupName $affinityGroupName -affinityGroupLabel $affinityGroupLabel -affinityGroupLocation $affinityGroupLocation
$hostedService = Create-HostedService -subscriptionId $subscriptionId -managementCertificate $managementCertificate -hostedServiceName $hostedServiceName -hostedServiceLabel $hostedServiceLabel -affinityGroupName $affinityGroupName
$storageAccount = Create-StorageAccount -subscriptionId $subscriptionId -managementCertificate $managementCertificate -storageAccountName $storageAccountName -storageAccountLabel $storageAccountLabel -affinityGroupName $affinityGroupName
Delete-StagingEnvironment -hostedService $hostedService
Create-Deployment -hostedService $hostedService -packageFilePath $packageFilePath -configurationFilePath $configurationFilePath -deploymentLabel $deploymentLabel -storageAccountName $storageAccountName -promoteToProductionEnvironment $promoteToProductionEnvironmentValue -removeStagingEnvironmentAfterwards $removeStagingEnvironmentAfterwardsValue