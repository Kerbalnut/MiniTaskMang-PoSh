
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
Function Get-DefaultStatuses {
	<#
	.SYNOPSIS
	Returns a list of the default categories/contexts for a new MTM project.
	.DESCRIPTION
	.NOTES
	#>
	[Alias("Get-DefaultStatus")]
	#Requires -Version 3
	[CmdletBinding()]
	Param()
	#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	$StatusNames = @()
	$StatusNames += 'New'
	$StatusNames += 'Active'
	$StatusNames += 'In-progress'
	$StatusNames += 'Paused'
	$StatusNames += 'Complete'
	$StatusNames += 'Deleted'
	$StatusNames += 'On-hold'
	$StatusNames += 'Backburner'
	Return $StatusNames
} # End of Get-DefaultStatuses function.
Set-Alias -Name 'Get-DefaultStatus' -Value 'Get-DefaultStatuses'
#-----------------------------------------------------------------------------------------------------------------------

#-----------------------------------------------------------------------------------------------------------------------
Function Get-AllPowerShellColors {
	<#
	.SYNOPSIS
	Returns a list of the default categories/contexts for a new MTM project.
	.DESCRIPTION
	.NOTES
	.LINK
	https://stackoverflow.com/questions/20541456/list-of-all-colors-available-for-powershell
	#>
	[Alias("Get-AllColors","Get-Colors","Get-ColorsList")]
	#Requires -Version 3
	[CmdletBinding()]
	Param(
		[Switch]$Grid,
		[Switch]$Quiet
	)
	#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	$Colors = [enum]::GetValues([System.ConsoleColor])
	If (!($Quiet)) {
		Foreach ($BgColor in $Colors) {
			Foreach ($FgColor in $Colors) {
				Write-Host "$FgColor|" -ForegroundColor $FgColor -BackgroundColor $BgColor -NoNewLine
			}
			If (!($Grid)) {Write-Host " on $BgColor"}
		}
	}
	If ($Quiet) {Return $Colors}
} # End of Get-AllPowerShellColors function.
Set-Alias -Name 'Get-AllColors' -Value 'Get-AllPowerShellColors'
Set-Alias -Name 'Get-Colors' -Value 'Get-AllPowerShellColors'
Set-Alias -Name 'Get-ColorsList' -Value 'Get-AllPowerShellColors'
#-----------------------------------------------------------------------------------------------------------------------

#-----------------------------------------------------------------------------------------------------------------------
Function Get-RandomColorPair {
	<#
	.SYNOPSIS
	Returns a list of the default categories/contexts for a new MTM project.
	.DESCRIPTION
	.PARAMETER Number
	Number of color pairs to return. Will attempt to use as few repeating pairs as possible, up to the maximum number of available pairs.
	.PARAMETER ShowMaxNumber
	Returns the maximum number of available color pairs.
	.PARAMETER ShowAllPairs
	Display all available color pairs.
	.PARAMETER NoBrightColors
	Do not use color pairs with bright backgrounds.
	.PARAMETER ShowResults
	Display the randomly-chosen color pairs along with results.
	.NOTES
	.LINK
	https://stackoverflow.com/questions/20541456/list-of-all-colors-available-for-powershell
	#>
	#Requires -Version 3
	[CmdletBinding(DefaultParameterSetName = "GetNumberOfPairs")]
	Param(
		[Parameter(Position = 0, ParameterSetName = "GetNumberOfPairs")]
		[Alias('Count','n')]
		[Int]$Number,
		
		[Parameter(ParameterSetName = "GetNumberOfPairs")]
		[Switch]$ShowResults,
		
		[Parameter(ParameterSetName = "ShowMaxNumber")]
		[Switch]$ShowMaxNumber,
		
		[Parameter(ParameterSetName = "ShowAllPairs")]
		[Switch]$ShowAllPairs,
		
		[Switch]$NoBrightColors
	)
	#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	
	$ColorPairs = @(
		[PSCustomObject]@{ForeColor = 'Green'; BackColor = 'Black'; BeenUsed = $False; BrightColor = $False}
		[PSCustomObject]@{ForeColor = 'Cyan'; BackColor = 'DarkBlue'; BeenUsed = $False; BrightColor = $False}
		[PSCustomObject]@{ForeColor = 'Yellow'; BackColor = 'DarkGreen'; BeenUsed = $False; BrightColor = $False}
		[PSCustomObject]@{ForeColor = 'White'; BackColor = 'DarkCyan'; BeenUsed = $False; BrightColor = $False}
		[PSCustomObject]@{ForeColor = 'Magenta'; BackColor = 'DarkRed'; BeenUsed = $False; BrightColor = $False}
		[PSCustomObject]@{ForeColor = 'White'; BackColor = 'DarkMagenta'; BeenUsed = $False; BrightColor = $False}
		[PSCustomObject]@{ForeColor = 'Black'; BackColor = 'DarkYellow'; BeenUsed = $False; BrightColor = $False}
		[PSCustomObject]@{ForeColor = 'DarkRed'; BackColor = 'Gray'; BeenUsed = $False; BrightColor = $False}
		[PSCustomObject]@{ForeColor = 'DarkBlue'; BackColor = 'DarkGray'; BeenUsed = $False; BrightColor = $False}
		[PSCustomObject]@{ForeColor = 'Yellow'; BackColor = 'Blue'; BeenUsed = $False; BrightColor = $True}
		[PSCustomObject]@{ForeColor = 'Blue'; BackColor = 'Green'; BeenUsed = $False; BrightColor = $True}
		[PSCustomObject]@{ForeColor = 'DarkBlue'; BackColor = 'Cyan'; BeenUsed = $False; BrightColor = $True}
		[PSCustomObject]@{ForeColor = 'Yellow'; BackColor = 'Red'; BeenUsed = $False; BrightColor = $True}
		[PSCustomObject]@{ForeColor = 'Black'; BackColor = 'Magenta'; BeenUsed = $False; BrightColor = $True}
		[PSCustomObject]@{ForeColor = 'Blue'; BackColor = 'Yellow'; BeenUsed = $False; BrightColor = $True}
		[PSCustomObject]@{ForeColor = 'Black'; BackColor = 'White'; BeenUsed = $False; BrightColor = $True}
	)
	
	#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	
	If ($NoBrightColors) {
		$TempColorPairs = @()
		ForEach ($color in $ColorPairs) {
			If (($color.BrightColor) -eq $False) {
				$TempColorPairs += $color
			}
		}
		$ColorPairs = $TempColorPairs
		Remove-Variable -Name 'TempColorPairs'
	}
	
	If ($ShowMaxNumber) {
		Return ($ColorPairs.Count)
	}
	
	If ($ShowAllPairs) {
		ForEach ($color in $ColorPairs) {
			Write-Host "$($color.ForeColor) on $($color.BackColor)" -ForegroundColor ($color.ForeColor) -BackgroundColor ($color.BackColor) -NoNewline
			Write-Host " - $($color.ForeColor) on $($color.BackColor)"
		}
		Return
	}
	
	#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	
	$ChosenPairs = @()
	$AvailableRoundPicks = $ColorPairs
	$i = 0
	Do {
		$i++
		If (($AvailableRoundPicks.Count) -eq 1) {
			$Pick = 1
		} Else {
			$Pick = Get-Random -Minimum 1 -Maximum ($AvailableRoundPicks.Count)
		}
		
		Write-Verbose "Randomly picked $Pick out of $($AvailableRoundPicks.Count)."
		
		$TempAvailableRoundPicks = @()
		$j = 0
		ForEach ($color in $AvailableRoundPicks) {
			$j++
			If ($j -eq $Pick) {
				$ChosenPairs += $color
			} Else {
				$TempAvailableRoundPicks += $color
			}
		}
		If (($AvailableRoundPicks.Count) -eq 1) {
			$AvailableRoundPicks = $ColorPairs
		} Else {
			$AvailableRoundPicks = $TempAvailableRoundPicks
		}
	} Until ($i -ge $Number)
	
	$ChosenPairs = ($ChosenPairs | Select-Object -Property * -ExcludeProperty 'BeenUsed','BrightColor')
	
	If ($ShowResults) {
		ForEach ($color in $ChosenPairs) {
			Write-Host "$($color.ForeColor) on $($color.BackColor)" -ForegroundColor ($color.ForeColor) -BackgroundColor ($color.BackColor) -NoNewline
			Write-Host " - $($color.ForeColor) on $($color.BackColor)"
		}
	}
	
	Return $ChosenPairs
} # End of Get-RandomColorPair function.
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
	
	# Create Contexts file with default contexts
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
		[PSCustomObject]@{ColumnName = 'ID'; Type = 'INTEGER'}
		[PSCustomObject]@{ColumnName = 'Name'; Type = 'TEXT'}
		[PSCustomObject]@{ColumnName = 'ParentProjectID'; Type = 'INT'}
		[PSCustomObject]@{ColumnName = 'ContextID'; Type = 'INT'}
		[PSCustomObject]@{ColumnName = 'StatusID'; Type = 'INT'}
		[PSCustomObject]@{ColumnName = 'CreationDate'; Type = 'DATETIME'}
		[PSCustomObject]@{ColumnName = 'LastUpdateDate'; Type = 'DATETIME'}
		[PSCustomObject]@{ColumnName = 'CompletionDate'; Type = 'DATETIME'}
		[PSCustomObject]@{ColumnName = 'DeletionDate'; Type = 'DATETIME'}
	)
	
	Function ConvertTo-NewSQLTableString($TableName,$InputArray) {
		<#
		.NOTES
		$Query = "CREATE TABLE NAMES (fullname VARCHAR(100) PRIMARY KEY, surname TEXT, givenname TEXT, birthdate DATETIME)"
		.LINK
		https://www.tutorialspoint.com/sqlite/sqlite_using_autoincrement.htm
		#>
		$Query = "CREATE TABLE $TableName ("
		$TotalCount = $InputArray.Count
		$i = 0
		ForEach ($column in $InputArray) {
			$i++
			If ($i -eq 1) {
				$Query += "$($column.ColumnName) $($column.Type) PRIMARY KEY AUTOINCREMENT, "
			} ElseIf ($i -eq $TotalCount) {
				$Query += "$($column.ColumnName) $($column.Type)"
			} Else {
				$Query += "$($column.ColumnName) $($column.Type), "
			}
		}
		$Query += ")"
		Return $Query
	} # End of sub-function.
	
	$TasksTableName = "Tasks"
	
	$Query = ConvertTo-NewSQLTableString -TableName $TasksTableName -InputArray $TaskList
	Invoke-SqliteQuery -Query $Query -Database $Database
	
	If ((Test-Path $Database)) {
		Write-Verbose "SQLite database creation success."
	}
	
	If ($VerbosePreference -ne 'SilentlyContinue') {
		Invoke-SqliteQuery -Database $Database -Query "PRAGMA table_info($TasksTableName)"
	}
	
	$Contexts = @(
		[PSCustomObject]@{ColumnName = 'ID'; Type = 'INTEGER'}
		[PSCustomObject]@{ColumnName = 'Name'; Type = 'TEXT'}
		[PSCustomObject]@{ColumnName = 'ForeColor'; Type = 'TEXT'}
		[PSCustomObject]@{ColumnName = 'BackColor'; Type = 'TEXT'}
		[PSCustomObject]@{ColumnName = 'CreationDate'; Type = 'DATETIME'}
		[PSCustomObject]@{ColumnName = 'LastModifiedDate'; Type = 'DATETIME'}
	)
	
	$ContextsTableName = "Contexts"
	
	$Query = ConvertTo-NewSQLTableString -TableName $ContextsTableName -InputArray $Contexts
	Invoke-SqliteQuery -Query $Query -Database $Database
	
	If ($VerbosePreference -ne 'SilentlyContinue') {
		Invoke-SqliteQuery -Database $Database -Query "PRAGMA table_info($ContextsTableName)"
	}
	
	$Status = @(
		[PSCustomObject]@{ColumnName = 'ID'; Type = 'INTEGER'}
		[PSCustomObject]@{ColumnName = 'Name'; Type = 'TEXT'}
		[PSCustomObject]@{ColumnName = 'ForeColor'; Type = 'TEXT'}
		[PSCustomObject]@{ColumnName = 'BackColor'; Type = 'TEXT'}
		[PSCustomObject]@{ColumnName = 'CreationDate'; Type = 'DATETIME'}
		[PSCustomObject]@{ColumnName = 'LastModifiedDate'; Type = 'DATETIME'}
	)
	
	$StatusTableName = "Status"
	
	$Query = ConvertTo-NewSQLTableString -TableName $StatusTableName -InputArray $Status
	Invoke-SqliteQuery -Query $Query -Database $Database
	
	Invoke-SqliteQuery -Database $Database -Query "PRAGMA table_info($StatusTableName)"
	
	If ($VerbosePreference -ne 'SilentlyContinue') {
		Invoke-SqliteQuery -Database $Database -Query "PRAGMA table_info($ContextsTableName)"
	}
	
	#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	
	# Add default status list to Statuses table:
	
	Function ConvertTo-AddNewRowSqlQuery($TableName,$InputArray,$ValuesArray) {
		<#
		.LINK
		https://www.tutorialspoint.com/sqlite/sqlite_insert_query.htm
		.NOTES
		INSERT INTO TABLE_NAME [(column1, column2, column3,...columnN)]  
		VALUES (value1, value2, value3,...valueN);
		#>
		$Query = "INSERT INTO $TableName ("
		$TotalCount = $InputArray.Count
		$i = 0
		ForEach ($column in $InputArray) {
			$i++
			If (($column.ColumnName) -ne 'ID' -And ($column.ColumnName) -ne 'Index') {
				If ($i -eq $TotalCount) {
					$Query += "$($column.ColumnName)"
				} Else {
					$Query += "$($column.ColumnName), "
				}
			}
		}
		$Query += ")"
		$Query += "`n"
		$Query += "VALUES ("
		
		$i = 0
		ForEach ($value in $ValuesArray) {
			$i++
			If (($value.ColumnName) -ne 'ID' -And ($value.ColumnName) -ne 'Index') {
				If ($i -eq $TotalCount) {
					$Query += "$($value.ColumnName)"
				} Else {
					$Query += "$($value.ColumnName), "
				}
			}
		}
		$Query += ")"
		
		Return $Query
	} # End of sub-function.
	
	
	
	$StatusNames = Get-DefaultStatuses
	
	[System.Collections.Stack]$StatusColors = Get-RandomColorPair -Number ($StatusNames.Count)
	
	
	
	[System.Collections.Stack]$ContextsColors = Get-RandomColorPair -Number ($DefaultContexts.Count)
	
	$ContextValuesToAdd = @()
	$CreationDate = Get-Date
	ForEach ($context in $DefaultContexts) {
		$ColorPair = $ContextsColors.Pop()
		$ContextValuesToAdd += [PSCustomObject]@{Name = $context; ForeColor = ($ColorPair.ForeColor); BackColor = ($ColorPair.BackColor); CreationDate = $CreationDate; LastModifiedDate = $CreationDate}
	}
	
	
	$Contexts = @(
		[PSCustomObject]@{ColumnName = 'ID'; Type = 'INTEGER'}
		[PSCustomObject]@{ColumnName = 'Name'; Type = 'TEXT'}
		[PSCustomObject]@{ColumnName = 'ForeColor'; Type = 'TEXT'}
		[PSCustomObject]@{ColumnName = 'BackColor'; Type = 'TEXT'}
		[PSCustomObject]@{ColumnName = 'CreationDate'; Type = 'DATETIME'}
		[PSCustomObject]@{ColumnName = 'LastModifiedDate'; Type = 'DATETIME'}
	)
	
	
	
	$Status = @(
		[PSCustomObject]@{ColumnName = 'ID'; Type = 'INTEGER'}
		[PSCustomObject]@{ColumnName = 'Name'; Type = 'TEXT'}
		[PSCustomObject]@{ColumnName = 'ForeColor'; Type = 'TEXT'}
		[PSCustomObject]@{ColumnName = 'BackColor'; Type = 'TEXT'}
		[PSCustomObject]@{ColumnName = 'CreationDate'; Type = 'DATETIME'}
		[PSCustomObject]@{ColumnName = 'LastModifiedDate'; Type = 'DATETIME'}
	)
	
	
	
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


