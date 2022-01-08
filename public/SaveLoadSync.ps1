
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
	Prints complete list of every available PowerShell color with Foreground and Background examples.
	.DESCRIPTION
	.PARAMETER Grid
	Supresses standard (default-colored) suffix text printed after each color example, which usually over-runs standard PowerShell console window width, causing a line break.
	.PARAMETER Quiet
	Returns complete list of color names only. No other Write-Host output is printed to console. Overrides other switches that produce output.
	.EXAMPLE
	Get-AllPowerShellColors -Grid
	
	Prints to console a list of every powershell color applied in every variety of Foreground color and Background color combination. Traditionally, there are 16 available colors, so this switch generates a nice-looking grid on standard-width PowerShell terminal.
	.EXAMPLE
	Get-AllPowerShellColors -List
	
	Returns list of available named PowerShell colors.
	.EXAMPLE
	Get-AllPowerShellColors -Quiet
	
	Same command as above.
	.EXAMPLE
	(Get-AllPowerShellColors -Quiet).Count
	
	Returns number of available PowerShell colors.
	.EXAMPLE
	[string[]](Get-AllPowerShellColors -Quiet) | Sort-Object
	
	Returns list of available named PowerShell colors, in alphabetical order.
	.EXAMPLE
	Get-AllPowerShellColors -Grid -Quiet
	.NOTES
	.LINK
	https://stackoverflow.com/questions/20541456/list-of-all-colors-available-for-powershell
	#>
	[Alias("Get-AllColors","Get-Colors","Get-ColorsList")]
	#Requires -Version 3
	[CmdletBinding()]
	Param(
		[Alias('ShowExamples','Show','Examples')]
		[Switch]$Grid,
		
		[Alias('List','q','l')]
		[Switch]$Quiet
	)
	#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	$Colors = [enum]::GetValues([System.ConsoleColor])
	If (!($Quiet)) {
		Foreach ($BgColor in $Colors) {
			Foreach ($FgColor in $Colors) {
				Write-Host "$FgColor|" -ForegroundColor $FgColor -BackgroundColor $BgColor -NoNewLine
			}
			If (!($Grid)) {Write-Host " on $BgColor"} Else {Write-Host ""}
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
	
	.DESCRIPTION
	.PARAMETER Number
	Number of color pairs to return. Will attempt to use as few repeating pairs as possible, up to the maximum number of available pairs. If more than the maximum is requested, some pairs will be repeated.
	.PARAMETER ShowResults
	Prints examples of the randomly-chosen color pairs to terminal, along with the results returned to pipeline.
	
	Displayed using Write-Host with -ForegroundColor and -BackgroundColor options
	.PARAMETER ShowMaxNumber
	Returns the maximum number of available color pairs.
	.PARAMETER ShowAllPairs
	Prints all available color pairs directly to terminal. Does not randomize output.
	
	Displayed using Write-Host with -ForegroundColor and -BackgroundColor options.
	.PARAMETER NoBrightColors
	Do not use color-pairs with bright backgrounds.
	.PARAMETER RawOutput
	Returns raw array of all available color-pairs this function contains.  Does not randomize output.
	.EXAMPLE
	Get-RandomColorPair -ShowMaxNumber
	
	Returns an integer value of the maximum number of color-pairs this function can generate. If more than the maximum is requested, some pairs will be repeated.
	.EXAMPLE
	Get-RandomColorPair -ShowAllPairs
	
	Prints an example of every available color-pair to the terminal, using Write-Host with -ForegroundColor and -BackgroundColor options.
	.EXAMPLE
	Get-RandomColorPair -ShowResults -Number (Get-RandomColorPair -ShowMaxNumber) | Out-Null
	
	Same as above command:
	Get-RandomColorPair -ShowAllPairs
	.EXAMPLE
	Get-RandomColorPair -ShowAllPairs -NoBrightColors
	
	Same as above command, except color pairs with bright backgrounds are restricted.
	.EXAMPLE
	Get-RandomColorPair -ShowMaxNumber -NoBrightColors
	
	Returns integer of maximum number of color-pairs this function contains, without bright backgrounds.
	.EXAMPLE
	(Get-RandomColorPair -ShowMaxNumber) - (Get-RandomColorPair -ShowMaxNumber -NoBrightColors)
	
	Opposite of above command:
	Returns integer of number of color-pairs WITH bright backgrounds.
	.EXAMPLE
	Get-RandomColorPair -RawOutput
	.NOTES
	.LINK
	https://stackoverflow.com/questions/20541456/list-of-all-colors-available-for-powershell
	#>
	#Requires -Version 3
	#[CmdletBinding(DefaultParameterSetName = "GetNumberOfPairs")]
	[CmdletBinding(DefaultParameterSetName = "ShowAllPairs")]
	Param(
		[Parameter(Position = 0, Mandatory = $True, ParameterSetName = "GetNumberOfPairs")]
		[Alias('Count','n')]
		[Int]$Number,
		
		[Parameter(ParameterSetName = "GetNumberOfPairs")]
		[Switch]$ShowResults,
		
		[Parameter(ParameterSetName = "ShowMaxNumber")]
		[Switch]$ShowMaxNumber,
		
		[Parameter(ParameterSetName = "ShowAllPairs")]
		[Switch]$ShowAllPairs,
		
		[Parameter(ParameterSetName = "RawOutput")]
		[Switch]$RawOutput,
		
		[Switch]$NoBrightColors
	)
	#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	
	# Define color-pairs array:
	
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
	
	If ($RawOutput) {
		Return $ColorPairs
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
	If the FolderPath parameter is used, that folder's name will become the project's name. If SourcePath is defined, the ProjectName parameter also must be defined, and will become the new project folder. Folders will be created if the paths don't exist.
	
	Project tracking will use multiple files. It's recommended to choose a dedicated folder path that is empty.
	.PARAMETER FolderPath
	The folder name for provided FolderPath will become the project's name. Recommended to choose an empty folder dedicated to the project. Folders will be created if they do not exist. Not compatible with SourcePath or ProjectName parameters.
	.PARAMETER SourcePath
	Path for the project folder to be created in. Use ProjectName to define this new folder name. Folders will be created if they do not exist. Not compatible with FolderPath.
	.PARAMETER ProjectName
	Project folder name. Requires SourcePath parameter to define where this folder will be created. Not compatible with FolderPath.
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
	New-ProjectInit -FolderPath "$Home\Documents\GitHub\MiniTaskMang-PoSh\Test Project" -Verbose
	.EXAMPLE
	New-ProjectInit -FolderPath "$Home\Documents\GitHub\MiniTaskMang-PoSh\Test Nested Folder\parent 1\child 2\Test Project" -Verbose
	#>
	#Requires -Version 3
	[Alias('New-ProjectInit','New-TaskTrackingInit')]
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
	$CommonParameters = @{
		Verbose = [System.Management.Automation.ActionPreference]$VerbosePreference
		Debug = [System.Management.Automation.ActionPreference]$DebugPreference
	}
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
	
	#-----------------------------------------------------------------------------------------------------------------------
	
	# Start building default Contexts, Statuses, and Tasks lists:
	
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
	
	$Contexts = @(
		[PSCustomObject]@{ColumnName = 'ID'; Type = 'INTEGER'}
		[PSCustomObject]@{ColumnName = 'Name'; Type = 'TEXT'}
		[PSCustomObject]@{ColumnName = 'ForeColor'; Type = 'TEXT'}
		[PSCustomObject]@{ColumnName = 'BackColor'; Type = 'TEXT'}
		[PSCustomObject]@{ColumnName = 'Enabled'; Type = 'TEXT'}
		[PSCustomObject]@{ColumnName = 'CreationDate'; Type = 'DATETIME'}
		[PSCustomObject]@{ColumnName = 'LastModifiedDate'; Type = 'DATETIME'}
	)
	
	$Status = @(
		[PSCustomObject]@{ColumnName = 'ID'; Type = 'INTEGER'}
		[PSCustomObject]@{ColumnName = 'Name'; Type = 'TEXT'}
		[PSCustomObject]@{ColumnName = 'ForeColor'; Type = 'TEXT'}
		[PSCustomObject]@{ColumnName = 'BackColor'; Type = 'TEXT'}
		[PSCustomObject]@{ColumnName = 'Enabled'; Type = 'TEXT'}
		[PSCustomObject]@{ColumnName = 'CreationDate'; Type = 'DATETIME'}
		[PSCustomObject]@{ColumnName = 'LastModifiedDate'; Type = 'DATETIME'}
	)
	
	$TasksTableName = "Tasks"
	
	$ContextsTableName = "Contexts"
	
	$StatusTableName = "Status"
	
	$DefaultContexts = Get-DefaultContexts @CommonParameters
	$DefaultContexts = Get-DefaultContexts
	
	$StatusNames = Get-DefaultStatuses @CommonParameters
	$StatusNames = Get-DefaultStatuses
	
	[System.Collections.Stack]$StatusColors = Get-RandomColorPair -Number ($StatusNames.Count) @CommonParameters
	
	[System.Collections.Stack]$ContextsColors = Get-RandomColorPair -Number ($DefaultContexts.Count) @CommonParameters
	
	[System.Collections.Stack]$StatusColors = Get-RandomColorPair -Number ($StatusNames.Count)
	[System.Collections.Stack]$ContextsColors = Get-RandomColorPair -Number ($DefaultContexts.Count)
	
	#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	
	# Build default values array
	Write-Verbose "Building default Status values array"
	$CreationDate = Get-Date
	$StatusValuesToAdd = @()
	$i = 0
	ForEach ($status in $StatusNames) {
		$i++
		$ColorPair = $StatusColors.Pop()
		$StatusValuesToAdd += [PSCustomObject]@{
			ID = $i
			Name = $status
			ForeColor = ($ColorPair.ForeColor)
			BackColor = ($ColorPair.BackColor)
			Enabled = $True
			CreationDate = $CreationDate
			LastModifiedDate = $CreationDate
		}
	}
	
	If ($VerbosePreference -ne 'SilentlyContinue') {
		$StatusValuesToAdd | Format-Table
	}
	
	Write-Verbose "Building default Context values array"
	$ContextValuesToAdd = @()
	$i = 0
	ForEach ($context in $DefaultContexts) {
		$i++
		$ColorPair = $ContextsColors.Pop()
		$ContextValuesToAdd += [PSCustomObject]@{
			ID = $i
			Name = $context
			ForeColor = ($ColorPair.ForeColor)
			BackColor = ($ColorPair.BackColor)
			Enabled = $True
			CreationDate = $CreationDate
			LastModifiedDate = $CreationDate
		}
	}
	
	If ($VerbosePreference -ne 'SilentlyContinue') {
		$ContextValuesToAdd | Format-Table
	}
	
	#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	
	# Create a sample/demo task(s) to fill out the brand-new projects list so it doesn't look blank.
	
	# If making an example for every possible context/status, find which one has the most:
	$NumOfValues = @()
	$NumOfValues += ($StatusNames.Count)
	$NumOfValues += ($DefaultContexts.Count)
	$Max = $NumOfValues | Measure-Object -Maximum
	
	$NumOfExampleTasks = $Max.Maximum
	
	# Build values array
	Write-Verbose "Building demo tasks array"
	$DemoTasksToAdd = @()
	$StatusSelection = 0
	$ContextSelection = 0
	For ($i = 1; $i -lt ($NumOfExampleTasks + 1); $i++) {
		If ($StatusSelection -lt ($StatusNames.Count)) {
			$StatusSelection++
		} Else {
			$StatusSelection = 1
		}
		If ($ContextSelection -lt ($DefaultContexts.Count)) {
			$ContextSelection++
		} Else {
			$ContextSelection = 1
		}
		$DemoTasksToAdd += [PSCustomObject]@{
			ID = $i
			Name = "Demo Task $i"
			ParentProjectID = $null
			ContextID = $ContextSelection
			StatusID = $StatusSelection
			CreationDate = $CreationDate
			LastUpdateDate = $CreationDate
			CompletionDate = $null
			DeletionDate = $null
		}
	}
	
	If ($VerbosePreference -ne 'SilentlyContinue') {
		$DemoTasksToAdd | Format-Table
	}
	
	#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	
	# Export demo data to data source files, whatever format they may be:
	
	$Method = 0
	switch ($Method) {
		0 {
			Write-Verbose "CSV data type chosen."
			
			$FileExtension = ".csv"
			$ContextsFileName = $ContextsTableName + $FileExtension
			$StatusesFileName = $StatusTableName + $FileExtension
			$TasksFileName = $TasksTableName + $FileExtension
			$ContextsPath = Join-Path -Path $ProjectPath -ChildPath $ContextsFileName
			$StatusesPath = Join-Path -Path $ProjectPath -ChildPath $StatusesFileName
			$TasksListPath = Join-Path -Path $ProjectPath -ChildPath $TasksFileName
			
			$StatusValuesToAdd | Export-Csv -Path $StatusesPath -NoTypeInformation
			$ContextValuesToAdd | Export-Csv -Path $ContextsPath -NoTypeInformation
			$DemoTasksToAdd | Export-Csv -Path $TasksListPath -NoTypeInformation
			
		}
		1 {
			Write-Verbose "XML data type chosen."
		}
		2 {
			Write-Verbose "JSON data type chosen."
		}
		Default {
			Write-Error "Data file format choice error."
			Throw "Data file format choice error."
		}
	}
	
	
	
	
	
	Return
	
	#
	
	#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	
	# Create default categories/contexts list:
	
	$ContextsFileName = "Contexts.csv"
	
	$ContextsPath = Join-Path -Path $ProjectPath -ChildPath $ContextsFileName
	
	$DefaultContexts = Get-DefaultContexts @CommonParameters
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
	
	#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	
	#>
	
	
	
	
	#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
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
	
	Write-Verbose "Checking if DB file already exists: $Database"
	If ((Test-Path $Database)) {
		If ($Force) {
			Write-Warning "Database file already exists: `"$Database`""
		} Else {
			Write-Error "Database file already exists: `"$Database`""
			Throw "Database file already exists: `"$Database`""
		}
	}
	
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
			} ElseIf ($i -ge $TotalCount) {
				$Query += "$($column.ColumnName) $($column.Type)"
			} Else {
				$Query += "$($column.ColumnName) $($column.Type), "
			}
		}
		$Query += ")"
		Return $Query
	} # End of sub-function.
	
	# Tasks
	
	Write-Verbose "Attempting to create $TasksTableName table in $($DbFileName):"
	$Query = ConvertTo-NewSQLTableString -TableName $TasksTableName -InputArray $TaskList
	Invoke-SqliteQuery -Query $Query -Database $Database
	
	If ((Test-Path $Database)) {
		Write-Verbose "SQLite database creation success."
	}
	
	Write-Verbose "Showing column info for $TasksTableName table:"
	If ($VerbosePreference -ne 'SilentlyContinue') {
		Invoke-SqliteQuery -Database $Database -Query "PRAGMA table_info($TasksTableName)"
	}
	
	# Contexts
	
	Write-Verbose "Attempting to create $ContextsTableName table in $($DbFileName):"
	$Query = ConvertTo-NewSQLTableString -TableName $ContextsTableName -InputArray $Contexts
	Invoke-SqliteQuery -Query $Query -Database $Database
	
	Write-Verbose "Showing column info for $ContextsTableName table:"
	If ($VerbosePreference -ne 'SilentlyContinue') {
		Invoke-SqliteQuery -Database $Database -Query "PRAGMA table_info($ContextsTableName)"
	}
	
	# Status
	
	Write-Verbose "Attempting to create $StatusTableName table in $($DbFileName):"
	$Query = ConvertTo-NewSQLTableString -TableName $StatusTableName -InputArray $Status
	Invoke-SqliteQuery -Query $Query -Database $Database
	
	Write-Verbose "Showing column info for $StatusTableName table:"
	If ($VerbosePreference -ne 'SilentlyContinue') {
		Invoke-SqliteQuery -Database $Database -Query "PRAGMA table_info($StatusTableName)"
	}
	
	#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	
	# Add default status list to Statuses table:
	
	Function ConvertTo-AddNewRowSqlQuery($TableName,$InputArray) {
		<#
		.LINK
		https://www.tutorialspoint.com/sqlite/sqlite_insert_query.htm
		.NOTES
		INSERT INTO TABLE_NAME [(column1, column2, column3,...columnN)]  
		VALUES (value1, value2, value3,...valueN);
		#>
		$ColumnNames = ""
		$ColumnValues = ""
		$TotalCount = $InputArray.Count
		$i = 0
		ForEach ($KeyValuePair in $InputArray) {
			$i++
			ForEach ($property in ($KeyValuePair.PsObject.Properties)) {
				If (($property.Name) -ne 'ID' -And ($property.Name) -ne 'Index') {
					If ($i -ge $TotalCount) {
						$ColumnNames += "$($property.Name)"
						$ColumnValues += "$($property.Value)"
					} Else {
						$ColumnNames += "$($property.Name), "
						$ColumnValues += "$($property.Value), "
					} # If last item
				} # If not ID or Index
			} # ForEach Property
		} # ForEach Pair
		
		# Construct query string:
		$Query = "INSERT INTO $TableName ($ColumnNames)`n"
		$Query += "VALUES ($ColumnValues);"
		
		Return $Query
	} # End of sub-function.
	
	# Convert value arrays to SQL queries:
	Write-Verbose "Converting default Status array values to SQL queries"
	$StatusQueriesToAdd = @()
	ForEach ($StatusValue in $StatusValuesToAdd) {
		$StatusQueriesToAdd += ConvertTo-AddNewRowSqlQuery -TableName $StatusTableName -InputArray $StatusValue
		#$StatusQueriesToAdd += (ConvertTo-AddNewRowSqlQuery -TableName $StatusTableName -InputArray $StatusValue) + "`n"
	}
	
	Write-Verbose "Converting default Context array values to SQL queries"
	$ContextQueriesToAdd = @()
	ForEach ($ContextValue in $ContextValuesToAdd) {
		$ContextQueriesToAdd += ConvertTo-AddNewRowSqlQuery -TableName $ContextsTableName -InputArray $ContextValue
		#$ContextQueriesToAdd += (ConvertTo-AddNewRowSqlQuery -TableName $ContextsTableName -InputArray $ContextValue) + "`n"
	}
	
	# Run SQL queries to add default values:
	Write-Verbose "Running queries to add default Status values to table."
	ForEach ($Query in $StatusQueriesToAdd) {
		Invoke-SqliteQuery -Query $Query -Database $Database
	}
	
	Write-Verbose "Running queries to add default Context values to table."
	ForEach ($Query in $ContextQueriesToAdd) {
		Invoke-SqliteQuery -Query $Query -Database $Database
	}
	
	#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	
	# Convert value array to SQL queries:
	Write-Verbose "Converting demo Tasks array to SQL queries"
	$TaskQueriesToAdd = @()
	ForEach ($Task in $DemoTasksToAdd) {
		$TaskQueriesToAdd += ConvertTo-AddNewRowSqlQuery -TableName $TasksTableName -InputArray $Task
		#$TaskQueriesToAdd += (ConvertTo-AddNewRowSqlQuery -TableName $TasksTableName -InputArray $Task) + "`n"
	}
	
	# Add demo tasks to Tasks table
	Write-Verbose "Running queries to add demo Tasks to $TasksTableName table."
	ForEach ($Query in $TaskQueriesToAdd) {
		Invoke-SqliteQuery -Query $Query -Database $Database
	}
	
	#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	
	Return
} # End of New-TaskTrackingInitiative function.
Set-Alias -Name 'New-ProjectInit' -Value 'New-TaskTrackingInitiative'
Set-Alias -Name 'New-TaskTrackingInit' -Value 'New-TaskTrackingInitiative'
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
	.EXAMPLE
	Get-MyTasks -Path "$Home\Documents\GitHub\MiniTaskMang-PoSh\Test Project"
	.LINK
	https://stackoverflow.com/questions/20705102/how-to-colorise-powershell-output-of-format-table
	https://docs.microsoft.com/en-us/windows/console/console-virtual-terminal-sequences#text-formatting
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
	#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	
	$ProjectPath = $Path
	$TasksTableName = "Tasks"
	$ContextsTableName = "Contexts"
	$StatusTableName = "Status"
	
	$FileExtension = ".csv"
	$ContextsFileName = $ContextsTableName + $FileExtension
	$StatusesFileName = $StatusTableName + $FileExtension
	$TasksFileName = $TasksTableName + $FileExtension
	$ContextsPath = Join-Path -Path $ProjectPath -ChildPath $ContextsFileName
	$StatusesPath = Join-Path -Path $ProjectPath -ChildPath $StatusesFileName
	$TasksListPath = Join-Path -Path $ProjectPath -ChildPath $TasksFileName
	
	$Tasks = Import-Csv -Path $TasksListPath
	$Contexts = Import-Csv -Path $ContextsPath
	$Statuses = Import-Csv -Path $StatusesPath
	
	#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	
	#https://stackoverflow.com/questions/20705102/how-to-colorise-powershell-output-of-format-table
	
	#https://docs.microsoft.com/en-us/windows/console/console-virtual-terminal-sequences#text-formatting
	
	dir -Exclude *.xml $pshome | Format-Table Mode,@{
		Label = "Name"
		Expression =
		{
			switch ($_.Extension)
			{
				'.exe' { $color = "93"; break }
				'.ps1xml' { $color = '32'; break }
				'.dll' { $color = "35"; break }
			   default { $color = "0" }
			}
			$e = [char]27
		   "$e[${color}m$($_.Name)${e}[0m"
		}
	 },Length
	
	#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	
	[string[]](Get-AllPowerShellColors -Quiet) | Sort-Object
	
	If ($DebugPreference -ne 'SilentlyContinue') {
		$Tasks | Format-Table
		$Contexts | Format-Table
		$Statuses | Format-Table
	}
	
	#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	
	Function ConvertTo-VtColorString($ForeColor,$BackColor) {
		
		switch ($_.Extension) {
			'.exe' { $color = "93"; break }
			'.ps1xml' { $color = '32'; break }
			'.dll' { $color = "35"; break }
			default { $color = "0" }
		}
		
		[string[]](Get-AllPowerShellColors -Quiet) | Sort-Object
		
		switch ($ForeColor) {
			'Black' {}
			'Blue' {}
			'Cyan' {}
			'DarkBlue' {}
			'DarkCyan' {}
			'DarkGray' {}
			'DarkGreen' {}
			'DarkMagenta' {}
			'DarkRed' {}
			'DarkYellow' {}
			'Gray' {}
			'Green' {}
			'Magenta' {}
			'Red' {}
			'White' {}
			'Yellow' {}
			'.exe' { $fcolor = "93"; break }
			Default {
				#0 	Default 	Returns all attributes to the default state prior to modification
				#39 	Foreground Default 	Applies only the foreground portion of the defaults (see 0)
				#49 	Background Default 	Applies only the background portion of the defaults (see 0)
				$fcolor = "39"
			}
		}
	}
	
	#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	
	$Tasks | Format-Table -Property ID, Name, ParentProjectID, @{
		Label = "ContextID"
		Expression = {
			Write-Host "ContextID = $($_.Name)"
			
			ForEach ($context in $Contexts) {
				If ($context.ID -eq ($_.ContextID)) {
					$ForegroundColorSel = $context.ForeColor
					$BackgroundColorSel = $context.BackColor
				}
			}
			
			switch ($_.Extension) {
				'.exe' { $color = "93"; break }
				'.ps1xml' { $color = '32'; break }
				'.dll' { $color = "35"; break }
				default { $color = "0" }
			}
			$e = [char]27
			"$e[${color}m$($_.Name)${e}[0m"
		}
	}
	
	
	$Tasks | Format-Table -Property ID, Name, ParentProjectID, @{
		Label = "ContextID"
		Expression =
		{
			Write-Host "ContextID = $($_.ContextID)"
			
		}
	}
	
	
	
	
	
	
	#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	
	Write-PSObject $servers -MatchMethod Exact -Column "Manufacture" -Value "HP" -ValueForeColor Yellow -ValueBackColor Red -RowForeColor White -RowBackColor Blue;
	
	Write
	
	
	#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	
	Function Get-HighlightedText($ListObj,$ID) {
		
	}
	
	#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	
	
	
	
	
	Return
} # End of Get-MyTasks function.
Set-Alias -Name 'Get-Tasks' -Value 'Get-MyTasks'
Set-Alias -Name 'Get-MyProgress' -Value 'Get-MyTasks'
Set-Alias -Name 'Get-MyItems' -Value 'Get-MyTasks'
Set-Alias -Name 'Get-MyProgressItems' -Value 'Get-MyTasks'
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


