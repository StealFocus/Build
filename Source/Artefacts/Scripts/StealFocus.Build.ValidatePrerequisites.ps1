param(
		[string]$azurePublishActionRequired = $(throw '$azurePublishActionRequired is a required parameter')
	)

[bool]$azurePublishActionRequiredValue = [System.Convert]::ToBoolean($azurePublishActionRequired)

Import-Module .\StealFocus.Build.psm1 -DisableNameChecking

Check-Prerequisites -azurePublishActionRequired $azurePublishActionRequiredValue
