
#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Public:

#-----------------------------------------------------------------------------------------------------------------------
Function New-TaskTrackingInitiative {
	[Alias('New-ProjectInit')]
	#Requires -Version 3
	<#
	.SYNOPSIS
	Creates the required files to start a MiniTaskMang (MTM) project at folder path.
	.DESCRIPTION
	Desc
	.NOTES
	Notes
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
	<#
	.SYNOPSIS
	Create a new action item in default MTM project.
	.DESCRIPTION
	.NOTES
	#>
	#Requires -Version 3
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
Function New-Category {
	[Alias('New-Context')]
	#Requires -Version 3
	<#
	.SYNOPSIS
	Add new category/context to MTM project.
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
} # End of New-Category function.
Set-Alias -Name 'New-Context' -Value 'New-Category'
#-----------------------------------------------------------------------------------------------------------------------

#-----------------------------------------------------------------------------------------------------------------------
Function Get-MyTaskStatus {
	[Alias('Get-TaskStatus','Get-MyStatus')]
	#Requires -Version 3
	<#
	.SYNOPSIS
	Get current status of active MTM task.
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
} # End of Get-MyTaskStatus function.
Set-Alias -Name 'Get-MyStatus' -Value 'Get-MyTaskStatus'
#-----------------------------------------------------------------------------------------------------------------------

#-----------------------------------------------------------------------------------------------------------------------
Function Get-MyTasks {
	[Alias('Get-Tasks','Get-MyProgress','Get-MyItems','Get-MyProgressItems')]
	#Requires -Version 3
	<#
	.SYNOPSIS
	Print list of MTM tasks from default project.
	.DESCRIPTION
	Desc
	.NOTES
	Notes
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
} # End of Get-MyTasks function.
Set-Alias -Name 'Get-Tasks' -Value 'Get-MyTasks'
Set-Alias -Name 'Get-MyProgress' -Value 'Get-MyTasks'
Set-Alias -Name 'Get-MyItems' -Value 'Get-MyTasks'
Set-Alias -Name 'Get-MyProgressItems' -Value 'Get-MyTasks'
#-----------------------------------------------------------------------------------------------------------------------




#-----------------------------------------------------------------------------------------------------------------------
Function New-TaskTrackingInitiativeTEST {
	[Alias('New-ProjectInitTEST')]
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
Set-Alias -Name 'New-ProjectInitTEST' -Value 'New-TaskTrackingInitiativeTEST'
#-----------------------------------------------------------------------------------------------------------------------


