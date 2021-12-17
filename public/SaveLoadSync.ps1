
#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Dependencies:

#https://github.com/RamblingCookieMonster/PSSQLite

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Public:

#-----------------------------------------------------------------------------------------------------------------------
Function Get-DefaultContexts {
	<#
	.SYNOPSIS
	Returns a list of the default categories/contexts for a new MTM project.
	.DESCRIPTION
	.NOTES
	#>
	[Alias("Get-DefaultCategories")]
	#Requires -Version 3
	[CmdletBinding()]
	Param()
	#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	$DefaultContexts = @()
	$DefaultContexts += "Calls"
	$DefaultContexts += "Emails"
	$DefaultContexts += "Tickets"
	$DefaultContexts += "Coding"
	$DefaultContexts += "Database/Infrastructure"
	$DefaultContexts += "Remediations"
	$DefaultContexts += "Administrative"
	Return $DefaultContexts
} # End of Get-DefaultContexts function.
Set-Alias -Name 'Get-DefaultCategories' -Value 'Get-DefaultContexts'
#-----------------------------------------------------------------------------------------------------------------------

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
	New-ProjectInit -FolderPath "$Home\Documents\GitHub\MiniTaskMang-PoSh\Test Project"
	.EXAMPLE
	New-ProjectInit -FolderPath "$Home\Documents\GitHub\MiniTaskMang-PoSh\Test Nested Folder\parent 1\child 2\Test Project"
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
	
	# Check if given folder path exists already or not, and create it if it doesn't.
	
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
					Write-Error "Could not create project folder."
					Throw "Could not create project folder."
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
					Write-Error "Could not create project folder."
					Throw "Could not create project folder."
				}
			}
			Default {Throw 'Horrible error: $FolderExists 2 wrong $Method'}
		}
	}
	
	#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	
	# Create default categories/contexts list:
	
	$ContextsFileName = "Contexts.csv"
	
	$ContextsPath = Join-Path -Path $ProjectPath -ChildPath $ContextsFileName
	
	$DefaultContexts = Get-DefaultContexts
	
	$DefaultContextsList = @()
	
	ForEach ($context in $DefaultContexts) {
		$Method = 0
		switch ($Method) {
			0 {
				$NewObj = New-Object -TypeName PSCustomObject -Property @{
					Name = $context
					Active = "Enabled"
				}
			}
			1 {
				$NewObj = [PSCustomObject]@{
					Name = $context
					Active = "Enabled"
				}
			}
			Default {Throw 'Horrible error: $DefaultContexts ForEach wrong $Method'}
		}
		$DefaultContextsList += $NewObj
	}
	
	# Get file extension:
	$Method = 0
	switch ($Method) {
		0 {
			$FileExtension = [System.IO.Path]::GetExtension($ContextsPath)
		}
		1 {
			$FileExtension = ((Split-Path -Path $ContextsPath -Leaf).Split('.'))[1]
		}
		2 {
			$FileExtension = (Get-ChildItem -Path $ContextsPath).Extension
		}
		Default {Throw 'Horrible error: Get file extension wrong $Method'}
	}
	
	# Regex remove any . in $FileExtension
	$FileExtension = $FileExtension -replace '^\.',''
	
	If ($FileExtension -eq "csv") {
		# https://codeigo.com/powershell/export-to-csv-in-powershell
		$DefaultContextsList | Export-Csv -Path $ContextsPath -NoTypeInformation #-Append
	} Else {
		New-Item -Path $ContextsPath -ItemType File
		
		Set-Content -Path $ContextsPath -Value $DefaultContextsList
	}
	
	#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	
	# Create tasks/projects list:
	
	$TasksFileName = "TasksList.csv"
	
	$TasksListPath = Join-Path -Path $ProjectPath -ChildPath $TasksFileName
	
	$TaskList = @(
		[PSCustomObject]@{Index = ''; Type = ''}
		[PSCustomObject]@{Name = ''; Type = ''}
		[PSCustomObject]@{ParentProjectID = ''; Type = ''}
		[PSCustomObject]@{ContextID = ''; Type = ''}
		[PSCustomObject]@{StatusID = ''; Type = ''}
		[PSCustomObject]@{CreationDate = ''; Type = ''}
		[PSCustomObject]@{LastUpdateDate = ''; Type = ''}
		[PSCustomObject]@{CompletionDate = ''; Type = ''}
		[PSCustomObject]@{DeletionDate = ''; Type = ''}
	)
	
	$TaskList = [PSCustomObject]@{
		Index = ''
		Name = ''
		ParentProjectID = ''
		ContextID = ''
		StatusID = ''
		CreationDate = ''
		LastUpdateDate = ''
		CompletionDate = ''
		DeletionDate = ''
	}
	
	$Contexts = @{
		Index = ''
		Name = ''
		ForeColor = ''
		BackColor = ''
		CreationDate = ''
	}
	
	$StatusNames = @(
	'New', 
	'Active', 
	'In-progress', 
	'Paused', 
	'Complete', 
	'Deleted', 
	'On-hold', 
	'Backburner')
	
	$Status = @{
		Index = ''
		Name = ''
		ForeColor = ''
		BackColor = ''
		CreationDate = ''
	}
	
	
	#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	
	# Make sure PSSQLite module is installed:
	#https://github.com/RamblingCookieMonster/PSSQLite
	If (!(Get-Module -ListAvailable -Name "PSSQLite")) {
		Write-Verbose "PSSQLite module is not installed. Attempting to install:"
		Try {
			Import-Module "PSSQLite"
		} Catch {
			Write-Verbose "Import-Module failed. Attempting Install-Module:"
			Install-Module "PSSQLite"
		}
		If (!(Get-Module -ListAvailable -Name "PSSQLite")) {
			Write-Error "PSSQLite could not be installed."
			Throw "PSSQLite could not be installed."
		}
	}
	
	# Create a SQLite database and table:
	
	$DbFileName = "TasksList.SQLite"
	
	$Database = Join-Path -Path $ProjectPath -ChildPath $DbFileName
	
	If ((Test-Path $Database)) {
		If ($Force) {
			Write-Warning "Database file already exists: `"$Database`""
		} Else {
			Write-Error "Database file already exists: `"$Database`""
			Throw "Database file already exists: `"$Database`""
		}
	}
	
	
	$TaskList = @(
		[PSCustomObject]@{ColumnName = 'Index'; Type = 'INTEGER'}
		[PSCustomObject]@{ColumnName = 'Name'; Type = 'TEXT'}
		[PSCustomObject]@{ColumnName = 'ParentProjectID'; Type = 'INT'}
		[PSCustomObject]@{ColumnName = 'ContextID'; Type = 'INT'}
		[PSCustomObject]@{ColumnName = 'StatusID'; Type = 'INT'}
		[PSCustomObject]@{ColumnName = 'CreationDate'; Type = 'DATETIME'}
		[PSCustomObject]@{ColumnName = 'LastUpdateDate'; Type = 'DATETIME'}
		[PSCustomObject]@{ColumnName = 'CompletionDate'; Type = 'DATETIME'}
		[PSCustomObject]@{ColumnName = 'DeletionDate'; Type = 'DATETIME'}
	)
	
	Function ConvertTo-NewSQLTableString($InputArray) {
		<#
		.NOTES
		$Query = "CREATE TABLE NAMES (fullname VARCHAR(100) PRIMARY KEY, surname TEXT, givenname TEXT, birthdate DATETIME)"
		#>
		$Query = "CREATE TABLE NAMES ("
		$TotalCount = $InputArray.Count
		$i = 0
		ForEach ($column in $InputArray) {
			$i++
			If ($i -eq 1) {
				$Query += "$($column.ColumnName) $($column.Type) PRIMARY KEY, "
			} ElseIf ($i -eq $TotalCount) {
				$Query += "$($column.ColumnName) $($column.Type)"
			} Else {
				$Query += "$($column.ColumnName) $($column.Type), "
			}
		}
		$Query += ")"
		Return $Query
	}
	
	$Query = ConvertTo-NewSQLTableString -InputArray $TaskList
	Invoke-SqliteQuery -Query $Query -Database $Database
	
	$Query = ConvertTo-NewSQLTableString -InputArray $TaskList
	Invoke-SqliteQuery -Query $Query -Database $Database
	
	If ((Test-Path $Database)) {
		Write-Verbose "SQLite database creation success."
	}
	
	Invoke-SqliteQuery -Database $Database -Query "PRAGMA table_info(NAMES)"
	
	
	
	
	
	#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	
	# Create a sample/demo task to fill out the brand-new projects list so it doesn't look blank.
	
	#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	
	Return $ContextsPath
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
	#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	
	
	Return
} # End of New-TaskTrackingInitiative function.
Set-Alias -Name 'New-ProjectInitTEST' -Value 'New-TaskTrackingInitiativeTEST'
#-----------------------------------------------------------------------------------------------------------------------


