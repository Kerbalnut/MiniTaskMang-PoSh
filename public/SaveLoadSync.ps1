
#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Public:

#-----------------------------------------------------------------------------------------------------------------------
Function New-TaskTrackingInitiative {
	<#
	.SYNOPSIS
	Creates the required files to start a MiniTaskMang (MTM) project at folder path.
	.DESCRIPTION
	Desc
	.NOTES
	Notes
	#>
	[Alias('New-ProjectInit')]
	#Requires -Version 3
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
	Create a new action item in default MTM (MiniTaskMang) project.
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
	<#
	.SYNOPSIS
	Add new category/context to MTM (MiniTaskMang) project.
	.DESCRIPTION
	.NOTES
	#>
	[Alias('New-Context')]
	#Requires -Version 3
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
	<#
	.SYNOPSIS
	Get current status of active MTM (MiniTaskMang) task.
	.DESCRIPTION
	.NOTES
	#>
	[Alias('Get-TaskStatus','Get-MyStatus')]
	#Requires -Version 3
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
Set-Alias -Name 'Get-TaskStatus' -Value 'Get-MyTaskStatus'
#-----------------------------------------------------------------------------------------------------------------------

#-----------------------------------------------------------------------------------------------------------------------
Function Get-MyTasks {
	<#
	.SYNOPSIS
	Print list of MTM (MiniTaskMang) tasks from default project.
	.DESCRIPTION
	Desc
	.NOTES
	Notes
	#>
	[Alias('Get-Tasks','Get-MyProgress','Get-MyItems','Get-MyProgressItems')]
	#Requires -Version 3
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
	<#
	.SYNOPSIS
	.DESCRIPTION
	.NOTES
	#>
	[Alias('New-ProjectInitTEST')]
	#Requires -Version 3
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


