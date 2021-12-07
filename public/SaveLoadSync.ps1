
#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

#-----------------------------------------------------------------------------------------------------------------------
Function New-TaskTrackingInitiative {
	[Alias('New-ProjectInit')]
	#Requires -Version 3
	<#
	.SYNOPSIS
	Creates the required files to start a MiniTaskMang project at folder path.
	.DESCRIPTION
	.NOTES
	#>
	[CmdletBinding(DefaultParameterSetName = "PathName")]
	Param(
		[Parameter(Mandatory = $True, Position = 0, 
				   ValueFromPipeline = $True, 
				   ValueFromPipelineByPropertyName = $True, 
				   HelpMessage = "Path to new project folder", 
				   ParameterSetName = "PathName")]
		[ValidateNotNullOrEmpty()]
		[Alias('Path')]
		[String]$PathName,
		
		[Parameter(Mandatory = $True, Position = 0, 
				   ValueFromPipelineByPropertyName = $True, 
				   HelpMessage = "Path to source folder for project", 
				   ParameterSetName = "SourcePath")]
		[Alias('Source')]
		[String]$SourcePath,
		
		[Parameter(Mandatory = $True, Position = 1, 
				   ValueFromPipelineByPropertyName = $True, 
				   HelpMessage = "Name for project", 
				   ParameterSetName = "SourcePath")]
		[Alias('Name')]
		[String]$ProjectName
		
	)
	#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	
	
	Return
} # End of New-TaskTrackingInitiative function.
Set-Alias -Name 'New-ProjectInit' -Value 'New-TaskTrackingInitiative'
#-----------------------------------------------------------------------------------------------------------------------



#-----------------------------------------------------------------------------------------------------------------------
Function New-Task {
	#Requires -Version 3
	<#
	.SYNOPSIS
	Create a new action item.
	.DESCRIPTION
	.NOTES
	#>
	[CmdletBinding()]
	Param(
		[Parameter(Mandatory = $True, 
				   Position = 0, 
				   ValueFromPipeline = $True, 
				   ValueFromPipelineByPropertyName = $True)]
		[ValidateNotNullOrEmpty()]
		[Alias('Task','Name','n')]
		[String]$TaskName,
		
		[Parameter(Mandatory = $True, 
				   Position = 1, 
				   ValueFromPipelineByPropertyName = $True)]
		[ValidateNotNullOrEmpty()]
		[Alias('Category','c')]
		[String]$Context,
		
		[Parameter(Mandatory = $False, ValueFromPipelineByPropertyName = $True)]
		[String]$ProjectPath
		
	)
	#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	
	
	Return
} # End of New-Task function.
#-----------------------------------------------------------------------------------------------------------------------



#-----------------------------------------------------------------------------------------------------------------------
Function New-TaskTrackingInitiative {
	[Alias('New-ProjectInit')]
	#Requires -Version 3
	<#
	.SYNOPSIS
	.DESCRIPTION
	.NOTES
	#>
	[CmdletBinding()]
	Param(
		[Parameter(Mandatory = $True, Position = 0,
		           ValueFromPipeline = $True, 
		           ValueFromPipelineByPropertyName = $True,
		           HelpMessage = "Path to ...")]
		[ValidateNotNullOrEmpty()]
		[String]$Path
		
	)
	
	Return
} # End of New-TaskTrackingInitiative function.
Set-Alias -Name 'New-ProjectInit' -Value 'New-TaskTrackingInitiative'
#-----------------------------------------------------------------------------------------------------------------------


