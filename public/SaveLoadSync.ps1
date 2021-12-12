
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
	.EXAMPLE
	New-TaskTrackingInitiative -FolderPath "$Home\Documents\MyTaskTracking"
	
	Sets up new project folder called "MyTaskTracking" within the user's "Documents" folder. This is usually something like: "C:\Users\<username>\Documents".
	.EXAMPLE
	New-ProjectInit -SourcePath "$Home\Documents" -ProjectName "MyTaskTracking"
	
	Exact same command as above, but formatted differently. 
	
	This time, the parameters are broken up into the "source folder", and the "project name" which will become the new project folder. 
	
	The alias "New-ProjectInit" is used instead of "New-TaskTrackingInitiative".
	.EXAMPLE
	New-ProjectInit -FolderPath 
	#>
	#Requires -Version 3
	[Alias('New-ProjectInit')]
	[CmdletBinding(DefaultParameterSetName = "PathName")]
	Param(
		[Parameter(ParameterSetName = "PathName", 
				   Mandatory = $True, Position = 0, 
				   ValueFromPipeline = $True, 
				   ValueFromPipelineByPropertyName = $True, 
				   HelpMessage = "Path to new project folder")]
		[ValidateNotNullOrEmpty()]
		[Alias('PathName','Path','ProjectFolder')]
		[String]$FolderPath,
		
		[Parameter(ParameterSetName = "SourcePath", 
				   Mandatory = $True, Position = 0, 
				   ValueFromPipelineByPropertyName = $True, 
				   HelpMessage = "Path to source folder for project")]
		[Alias('Source','SourceFolder')]
		[String]$SourcePath,
		
		[Parameter(ParameterSetName = "SourcePath", 
				   Mandatory = $True, Position = 1, 
				   ValueFromPipelineByPropertyName = $True, 
				   HelpMessage = "Name for project")]
		[Alias('Name')]
		[String]$ProjectName
		
	)
	#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	
	# If given full project folder name & path parameter together, separate them out.
	
	# Check if given folder path exists already or not, and create it if it doesn't.
	
	# If source folder given, combine with project name to get full project folder path.
	If ($SourcePath) {
		Write-Verbose "ParameterSetName = `"SourcePath`" chosen."
		$Method = 0
		switch ($Method) {
			0 {
				Write-Verbose "Method: '$Method' - PowerShell method, Join-Path"
				$ProjectPath = Join-Path -Path $SourcePath -ChildPath $ProjectName
			}
			1 {
				Write-Verbose "Method: '$Method' - concatenate strings"
				# Remove any trailing backslash \ at end of line (if it exists), using regular expressions:
				# Regex:
				# \\   : literal \ backslash, escaped using \ backslash
				# $    : end of line
				$SourcePath = $SourcePath -replace '\\$',''
				$ProjectPath = $SourcePath + "\" + $ProjectName
			}
			Default {Throw 'Horrible error: $SourcePath wrong $Method'}
		}
	} Else {
		$ProjectPath = $FolderPath
		Write-Verbose "ParameterSetName = `"PathName`" chosen."
	}
	Write-Verbose "`$ProjectPath = `"$ProjectPath`""
	
	#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	
	# Check if project source folder already exists:
	$FolderExists = $False
	$Method = 0
	switch ($Method) {
		0 {
			Write-Verbose "Method: '$Method' - Using PowerShell native command, Test-Path."
			If ( Test-Path -Path $ProjectPath ) {
				$FolderExists = $True
			}
		}
		1 {
			Write-Verbose "Method: '$Method' - Using (source) .NET method directly"
			If ( [System.IO.File]::Exists($ProjectPath) ) {
				$FolderExists = $True
			}
		}
		Default {Throw 'Horrible error: $FolderExists 1 wrong $Method'}
	}
	Write-Verbose "`$FolderExists = `"$FolderExists`""
	
	#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	
	# Create folder if it does not exist:
	
	If ( !($FolderExists) ) {
		Write-Verbose "Project folder does not exist. Attempting to create:"
		$Method = 0
		switch ($Method) {
			0 {
				Write-Verbose "Method: '$Method' - Using mkdir"
				Try {
					mkdir $ProjectPath
				} Catch {
					Write-Host "Error: Could not create project folder." -BackgroundColor Black -ForegroundColor Red
					$Error[0]
					$_.ToString()
					
				}
			}
			1 {
				Write-Verbose "Method: '$Method' - Using PowerShell native command, New-Item"
				Try {
					New-Item -Path $ProjectPath -ItemType "Directory"
				} Catch {
					Write-Host "Error: Could not create project folder." -BackgroundColor Black -ForegroundColor Red
					$Error[0]
					$_.ToString()
					Write-Error 
				}
			}
			Default {Throw 'Horrible error: $FolderExists 2 wrong $Method'}
		}
		
	}
	
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
	Single-line summary.
	.DESCRIPTION
	Multiple paragraphs describing in more detail what the function is, what it does, how it works, inputs it expects, and outputs it creates.
	.NOTES
	Some extra info about this function, like it's origins, what module (if any) it's apart of, and where it's from.
	
	Maybe some original author credits as well.
	#>
	[Alias("New-ProjectInitTEST")]
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


