
#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Dependencies:

#Requires -Version 3

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
	Returns a list of all available PowerShell colors.
	.DESCRIPTION
	Returns list of every available PowerShell color by default. When used with other switches, this function also produces Foreground and Background examples. 
	
	The -List switch prints output directly to the terminal using Write-Host, and -Grid produces an array object output that can be formatted as a table. 
	
	The -VtColors switch enables use of Virtual Terminal color codes, which greatly expands the range of colors available for use, and allows in-line text coloring. To find out if the type of PowerShell interface in use is compatible with Virtual Terminal colors, use the -ShowHostInfo switch. See also ConvertTo-VtColorString function.
	.PARAMETER List
	Prints a complete list of different ForeGround and BackGround color examples. Useful for choosing multiple fore/back color pairs.
	
	Not compatible with -Grid parameter.
	.PARAMETER AddColorLabels
	Adds non-color-formatted labels to -ColorList output.
	
	For a standard-width PowerShell terminal, this extra string length will overflow each line of printed output, so usually requires a wider than normal terminal width for formatted output.
	.PARAMETER Grid
	Returns an array object with details about color options, and a few color examples.
	
	Not compatible with -ColorList parameter.
	.PARAMETER VtColors
	Show addiitional options for Virtual Terminal colors.
	
	For more info on VT colors:
	https://docs.microsoft.com/en-us/windows/console/console-virtual-terminal-sequences#text-formatting
	.PARAMETER Alphabetic
	This switch is on by default, so this syntax is required to explicitly turn it off:
	Get-AllPowerShellColors -Alphabetic:$False
	.PARAMETER Quiet
	Returns complete list of color names only. No other Write-Host output is printed to console. Overrides other switches that produce host/terminal output. Pipeline output will still be produced.
	.PARAMETER ShowHostInfo
	Provides a curated list of some details of the host console/terminal executing the PowerShell commands, including default Foreground and Background colors, and if the host supports Virtual Terminal colors. 
	
	See the `Get-Host` command and $PSVersionTable built-in variable for more of this type of info.
	.EXAMPLE
	Get-AllPowerShellColors -ShowHostInfo
	
	Display infor about the current PowerShell terminal, including Virtual Terminal color support. 
	See `(Get-AllPowerShellColors -ShowHostInfo).SupportsVirtualTerminal` for direct value.
	.EXAMPLE
	Get-AllPowerShellColors
	
	Prints list of available PowerShell colors.
	.EXAMPLE
	(Get-AllPowerShellColors -Quiet).Count
	
	Returns number of available PowerShell colors. (Standard is 16)
	.EXAMPLE
	Get-AllPowerShellColors -Alphabetic:$False
	
	Do not produce alphabetic output. This switch is on by default, so this syntax is required to explicitly turn it off.
	
	Another way to explicitly sort output alphabetically, but is not necessary:
	PS\>[string[]](Get-AllPowerShellColors -Quiet) | Sort-Object
	.EXAMPLE
	Get-AllPowerShellColors -List
	
	Returns an example of every color Foreground + Background pair, in a printed output list using Write-Host.
	
	Alias for:
	PS\>Get-AllPowerShellColors -ColorList
	
	Use with the -AddColorLabels switch to include a default-colored tag with each line.
	
	E.g.
	PS\>Get-AllPowerShellColors -List -AddColorLabels
	
	For a standard powershell.exe terminal width (standard 120), each line of this output will end perfectly at the line break point, creating a grid. (When used with standard 16 colors.)
	But when this command is used with the -AddColorLabels switch, each line will additionally print with the color name in the default color scheme, causing overflow. A resized or non-default width powershell interface will change this.
	.EXAMPLE
	Get-AllPowerShellColors -Grid
	
	Prints to console a list of every powershell color applied in every variety of Foreground color and Background color combination. Traditionally, there are 16 available colors, so this switch generates a nice-looking grid on standard-width PowerShell terminal.
	
	Alias for:
	PS\>Get-AllPowerShellColors -ColorGrid
	.EXAMPLE
	Get-AllPowerShellColors -VtColors
	.EXAMPLE
	Get-AllPowerShellColors
	Get-AllPowerShellColors -Quiet
	Get-AllPowerShellColors -List
	Get-AllPowerShellColors -List -AddColorLabels
	Get-AllPowerShellColors -Grid
	Get-AllPowerShellColors -VtColors
	Get-AllPowerShellColors -List -Quiet
	Get-AllPowerShellColors -Grid -Quiet
	Get-AllPowerShellColors -VtColors -Quiet
	Get-AllPowerShellColors -BlackAndWhite
	Get-AllPowerShellColors -BlackAndWhite -Quiet
	Get-AllPowerShellColors -List -BlackAndWhite
	Get-AllPowerShellColors -Grid -BlackAndWhite
	Get-AllPowerShellColors -VtColors -BlackAndWhite
	Get-AllPowerShellColors -List -BlackAndWhite -Quiet
	Get-AllPowerShellColors -Grid -BlackAndWhite -Quiet
	Get-AllPowerShellColors -VtColors -BlackAndWhite -Quiet
	Get-AllPowerShellColors -List -VtColors
	Get-AllPowerShellColors -Grid -VtColors
	Get-AllPowerShellColors -List -VtColors -Quiet
	Get-AllPowerShellColors -Grid -VtColors -Quiet
	Get-AllPowerShellColors -List -VtColors -BlackAndWhite
	Get-AllPowerShellColors -Grid -VtColors -BlackAndWhite
	Get-AllPowerShellColors -List -VtColors -BlackAndWhite -Quiet
	Get-AllPowerShellColors -Grid -VtColors -BlackAndWhite -Quiet
	Get-AllPowerShellColors -ShowHostInfo
	.NOTES
	Version Notes:
	v1.0.0: 2022-01-12
	16 color selection based on PowerShell's defaults. Foreground and background colors supported. -List [-AddColorLabels], -Grid, -VtColors, -BlackAndWhite, and -Quiet parameters supported.
	
	Original repository:
	https://github.com/Kerbalnut/MiniTaskMang-PoSh
	https://github.com/Kerbalnut/MiniTaskMang-PoSh/blob/main/public/SaveLoadSync.ps1
	Copied to:
	https://github.com/Kerbalnut/SleepTimerPoSh
	https://github.com/Kerbalnut/SleepTimerPoSh/blob/main/Start-SleepTimer.ps1
	
	Develepment Notes:
	https://www.delftstack.com/howto/powershell/change-colors-in-powershell/
	
	[System.Enum]::GetValues('ConsoleColor') |
	ForEach-Object { Write-Host $_ -ForegroundColor $_ }
	.LINK
	https://github.com/Kerbalnut/MiniTaskMang-PoSh
	.LINK
	https://stackoverflow.com/questions/20541456/list-of-all-colors-available-for-powershell
	.LINK
	https://www.delftstack.com/howto/powershell/change-colors-in-powershell/
	.LINK
	ConvertTo-VtColorString
	#>
	[Alias("Get-AllColors","Get-Colors","Get-ColorsList")]
	#Requires -Version 3
	[CmdletBinding(DefaultParameterSetName = "ColorList")]
	Param(
		[Parameter(ParameterSetName = "ColorList")]
		[Alias('ColorList','l','cl')]
		[Switch]$List,
		
		[Parameter(ParameterSetName = "ColorList")]
		[Switch]$AddColorLabels,
		
		[Parameter(ParameterSetName = "ColorGrid")]
		[Alias('ColorGrid','g','cg','ShowExamples','show','examples')]
		[Switch]$Grid,
		
		#[Parameter(ParameterSetName = "ColorCompare")]
		#[Switch]$ConsoleColorComparison,
		
		[Parameter(ParameterSetName = "Default")]
		[Parameter(ParameterSetName = "ColorList")]
		[Parameter(ParameterSetName = "ColorGrid")]
		[Alias('vt')]
		[Switch]$VtColors,
		
		[Parameter(ParameterSetName = "Default")]
		[Parameter(ParameterSetName = "ColorList")]
		[Parameter(ParameterSetName = "ColorGrid")]
		[Alias('bw','bnw','black','white')]
		[Switch]$BlackAndWhite,
		
		[Parameter(ParameterSetName = "Default")]
		[Parameter(ParameterSetName = "ColorList")]
		[Parameter(ParameterSetName = "ColorGrid")]
		[Alias('q')]
		[Switch]$Quiet,
		
		[Parameter(ParameterSetName = "Default")]
		[Parameter(ParameterSetName = "ColorList")]
		[Parameter(ParameterSetName = "ColorGrid")]
		[Switch]$Alphabetic = $True,
		
		[Parameter(ParameterSetName = "ShowHostInfo")]
		[Alias('ShowHostDefaults','Defaults','HostDefaults','ConsoleDefaults','InterfaceDefaults','TerminalDefaults')]
		[Switch]$ShowHostInfo
		
	)
	#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	If ($List) {$ColorList = $True}
	If ($Grid) {$ColorGrid = $True}
	#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	If (!($Alphabetic)) {
		# Standard output (list of all color names):
		$Colors = [enum]::GetValues([System.ConsoleColor])
	} Else {
		# Alphabetic output:
		$Colors = [string[]]([enum]::GetValues([System.ConsoleColor])) | Sort-Object
	}
	#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	If ($BlackAndWhite) {
		$PureBlackVtFontColor = ConvertTo-VtColorString -ForeColor "Black" -TerminalType 'powershell.exe'
		$PureWhiteVtFontColor = ConvertTo-VtColorString -ForeColor "White" -TerminalType 'powershell.exe'
	}
	#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	$SupportsVirtualTerminal = (Get-Host).UI.SupportsVirtualTerminal
	If ($VtColors -And (!($SupportsVirtualTerminal)) ) {
		Write-Warning 'This host does not support Virtual Terminal colors. Run `Get-AllPowerShellColors -ShowHostInfo` for more info. Issues may occur when using the -VtColors switch on this host. See `Get-Help Get-AllPowerShellColors -Full` for more info on the -VtColors and -ShowHostInfo switches.'
	}
	#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	$HostInterfaceName = (Get-Host).Name
	#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	# Begin If/Else tree for returning/printing output, based on input switches: ColorList, ColorGrid, ShowHostInfo, VtColors, or none of the above.
	If ($ColorList -And !($Quiet)) {
		# Print list to terminal
		If (!($VtColors)) {
			
			[System.Enum]::GetValues('ConsoleColor') | ForEach-Object { Write-Host $_ -ForegroundColor $_ }
			
			ForEach ($BgColor in $Colors) {
				If ($BlackAndWhite) {
					Write-Host "Black|" -ForegroundColor 'Black' -BackgroundColor $BgColor -NoNewLine
					Write-Host "White|" -ForegroundColor 'White' -BackgroundColor $BgColor -NoNewLine
				} Else {
					ForEach ($FgColor in $Colors) {
						Write-Host "$FgColor|" -ForegroundColor $FgColor -BackgroundColor $BgColor -NoNewLine
					} # End ForEach ($FgColor)
				}
				If ($AddColorLabels -Or $BlackAndWhite) {Write-Host " on $BgColor"} Else {Write-Host ""}
			} # End ForEach ($BgColor)
		} Else {
			# TODO: Add $VtColors output
			Write-Warning "WIP."
		}
		#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		# End If ($ColorList)
	} ElseIf ($ColorGrid) { # End If ($ColorList)
		# Build GridObj array
		$GridObj = @()
		If (!($VtColors)) {
			# Just -Grid switch with no -VtColors switch
			ForEach ($color in $Colors) {
				If ($color -eq "DarkMagenta") {
					$ColorError = "(PoSh error: appears as blue powershell terminal background)"
				} ElseIf ($color -eq "DarkYellow") {
					$ColorError = "(PoSh error: appears as a lighter gray than 'Gray', almost white but not quite)"
				} ElseIf ($color -eq "Gray") {
					$ColorError = "(VsCode error: appears exact same as vscode white)"
				} Else {
					$ColorError = ""
				}
				
				$GridObj += [PSCustomObject]@{Color = $color; ColorError = $ColorError}
			} # End ForEach ($color in $Colors)
			# End If (!($VtColors))
		} Else {
			# When -Grid and -VtColors switches are used together:
			ForEach ($color in $Colors) {
				$BackColor = $color
				$BadColor = "Red"
				
				If ($BlackAndWhite) {
					$BadVtFontColor = ConvertTo-VtColorString -ForeColor $BadColor -TerminalType 'powershell.exe'
					
					$DefaultColor = (ConvertTo-VtColorString -BackColor $BackColor -Raw -TerminalType 'default')
					$PoShColor    = (ConvertTo-VtColorString -BackColor $BackColor -Raw -TerminalType 'powershell.exe')
					$VsCodeColor  = (ConvertTo-VtColorString -BackColor $BackColor -Raw -TerminalType 'Code.exe')
				} Else {
					$DefaultColor = (ConvertTo-VtColorString -ForeColor $BadColor -TerminalType 'powershell.exe') + ";" + (ConvertTo-VtColorString -BackColor $BackColor -Raw -TerminalType 'default')
					$PoShColor    = (ConvertTo-VtColorString -ForeColor $BadColor -TerminalType 'powershell.exe') + ";" + (ConvertTo-VtColorString -BackColor $BackColor -Raw -TerminalType 'powershell.exe')
					$VsCodeColor  = (ConvertTo-VtColorString -ForeColor $BadColor -TerminalType 'powershell.exe') + ";" + (ConvertTo-VtColorString -BackColor $BackColor -Raw -TerminalType 'Code.exe')
				}
				
				$BadTextColor = (ConvertTo-VtColorString -ForeColor $BadColor -TerminalType 'powershell.exe') + ";" + (ConvertTo-VtColorString -BackColor 'Black' -Raw -TerminalType 'Code.exe')
				
				If ($color -eq "DarkMagenta") {
					$ColorError = "(PoSh error: appears as blue powershell terminal background)"
					$ColorError = "$e[${BadTextColor}m$("$ColorError")${e}[0m"
				} ElseIf ($color -eq "DarkYellow") {
					$ColorError = "(PoSh error: appears as a lighter gray than 'Gray', almost white but not quite)"
					$ColorError = "$e[${BadTextColor}m$("$ColorError")${e}[0m"
				} ElseIf ($color -eq "Gray") {
					$ColorError = "(VsCode error: appears exact same as vscode white)"
					$ColorError = "$e[${BadTextColor}m$("$ColorError")${e}[0m"
				} Else {
					$ColorError = ""
				}
				
				$GridObj += [PSCustomObject]@{Default = $DefaultColor; PoSh = $PoShColor; VsCode = $VsCodeColor; ColorName = " on $BackColor"; ColorError = $ColorError}
			} # End ForEach ($color in $Colors)
			# End If ($VtColors)
		} # End If/Else ($VtColors)
		
		#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		# Return GridObj array as table
		If ($Quiet) {
			Return $GridObj
		} Else {
			If (!($VtColors)) {
				# Just -Grid switch with no -VtColors switch
				#https://stackoverflow.com/questions/20705102/how-to-colorise-powershell-output-of-format-table
				
				#Write-PSObject $GridObj -MatchMethod Exact -Column "Color" -Value "Yellow" -ValueForeColor Yellow -ValueBackColor Yellow -RowForeColor White -RowBackColor Blue;
				
				
				$GridObj | Format-Table -Property @{
					Label = "Color"
					Expression = {
						$colorstr = $_.Color
						If ($BlackAndWhite) {
							"$e[${colorstrblack}m$("Black|")${e}[0m${e}[${colorstrwhite}m$("White|")${e}[0m"
							
						} Else {
							Write-Host "       " -ForegroundColor $colorstr -BackgroundColor $colorstr -NoNewline
						}
					}
				}, ColorError
				# End $GridObj | Format-Table
				# End If (!($VtColors))
			} Else {
				# When -Grid and -VtColors switches are used together:
				$GridObj | Format-Table -Property @{
					Label = "Default"
					Expression = {
						$colorstr = $_.Default
						#https://stackoverflow.com/questions/20705102/how-to-colorise-powershell-output-of-format-table
						#https://docs.microsoft.com/en-us/windows/console/console-virtual-terminal-sequences#text-formatting
						# Escape key
						$e = [char]27
						# Magic string: VT escape sequences:
						# - ESC [ <n> m    Set the format of the screen and text as specified by <n>
						#    - 0    Default    Returns all attributes to the default state prior to modification
						#"$e[${colorstr}m$("       ")${e}[0m"
						If ($BlackAndWhite) {
							$colorstrblack = $PureBlackVtFontColor + ";" + $colorstr
							$colorstrwhite = $PureWhiteVtFontColor + ";" + $colorstr
							
							"$e[${colorstrblack}m$("Black|")${e}[0m${e}[${colorstrwhite}m$("White|")${e}[0m"
							
						} Else {
							"$e[${colorstr}m$("       ")${e}[0m"
						}
					}
				}, @{
					Label = "PoSh"
					Expression = {
						$colorstr = $_.PoSh
						#https://stackoverflow.com/questions/20705102/how-to-colorise-powershell-output-of-format-table
						#https://docs.microsoft.com/en-us/windows/console/console-virtual-terminal-sequences#text-formatting
						# Escape key
						$e = [char]27
						# Magic string: VT escape sequences:
						# - ESC [ <n> m    Set the format of the screen and text as specified by <n>
						#    - 0    Default    Returns all attributes to the default state prior to modification
						#"$e[${colorstr}m$("       ")${e}[0m"
						If ($BlackAndWhite) {
							If ($_.ColorName -like " on DarkMagenta*" -Or $_.ColorName -like " on DarkYellow*") {
								$colorstrblack = $BadVtFontColor + ";" + $colorstr
								$colorstrwhite = $BadVtFontColor + ";" + $colorstr
								$colorstrblack = $PureBlackVtFontColor + ";" + $colorstr
								$colorstrwhite = $PureWhiteVtFontColor + ";" + $colorstr
							} Else {
								$colorstrblack = $PureBlackVtFontColor + ";" + $colorstr
								$colorstrwhite = $PureWhiteVtFontColor + ";" + $colorstr
							}
							"$e[${colorstrblack}m$("Black|")${e}[0m${e}[${colorstrwhite}m$("White|")${e}[0m"
						} Else {
							If ($_.ColorName -like " on DarkMagenta*" -Or $_.ColorName -like " on DarkYellow*") {
								"$e[${colorstr}m$("???????")${e}[0m"
							} Else {
								"$e[${colorstr}m$("       ")${e}[0m"
							}
						}
					}
				}, @{
					Label = "VsCode"
					Expression = {
						$colorstr = $_.VsCode
						#https://stackoverflow.com/questions/20705102/how-to-colorise-powershell-output-of-format-table
						#https://docs.microsoft.com/en-us/windows/console/console-virtual-terminal-sequences#text-formatting
						# Escape key
						$e = [char]27
						# Magic string: VT escape sequences:
						# - ESC [ <n> m    Set the format of the screen and text as specified by <n>
						#    - 0    Default    Returns all attributes to the default state prior to modification
						#"$e[${colorstr}m$("       ")${e}[0m"
						If ($BlackAndWhite) {
							If ($_.ColorName -like " on Gray*") {
								$colorstrblack = $BadVtFontColor + ";" + $colorstr
								$colorstrwhite = $BadVtFontColor + ";" + $colorstr
								$colorstrblack = $PureBlackVtFontColor + ";" + $colorstr
								$colorstrwhite = $PureWhiteVtFontColor + ";" + $colorstr
							} Else {
								$colorstrblack = $PureBlackVtFontColor + ";" + $colorstr
								$colorstrwhite = $PureWhiteVtFontColor + ";" + $colorstr
							}
							"$e[${colorstrblack}m$("Black|")${e}[0m${e}[${colorstrwhite}m$("White|")${e}[0m"
						} Else {
							If ($_.ColorName -like " on Gray*") {
								"$e[${colorstr}m$("???????")${e}[0m"
							} Else {
								"$e[${colorstr}m$("       ")${e}[0m"
							}
						}
					}
				}, ColorName, ColorError
				# End $GridObj | Format-Table
			} # End If/Else ($VtColors)
		} # End If/Else ($Quiet)
		#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		# End ElseIf $ColorGrid
	} ElseIf ($ShowHostInfo) { # End ElseIf ($ColorGrid)
		$HostInfo = [PSCustomObject]@{
			Name = (Get-Host).Name
			WindowTitle = (Get-Host).UI.RawUI.WindowTitle
			Version = (Get-Host).Version
			PSVersion = $PSVersionTable.PSVersion
			CurrentCulture = (Get-Host).CurrentCulture
			CurrentUICulture = (Get-Host).CurrentUICulture
			Runspace = (Get-Host).Runspace
			SupportsVirtualTerminal = (Get-Host).UI.SupportsVirtualTerminal
			ForegroundColor = (Get-Host).UI.RawUI.ForegroundColor
			BackgroundColor = (Get-Host).UI.RawUI.BackgroundColor
		}
		Return $HostInfo
	} ElseIf ($VtColors) { # End ElseIf ($ShowHostInfo)
		# No other -List or -Grid param specified, but -VtColors is.
		
		$VtColorCodeArray = @()
		
		ForEach ($color in $Colors) {
			$DefaultForeColor = (ConvertTo-VtColorString -ForeColor $color -Raw -TerminalType 'default')
			$PoShForeColor    = (ConvertTo-VtColorString -ForeColor $color -Raw -TerminalType 'powershell.exe')
			$VsCodeForeColor  = (ConvertTo-VtColorString -ForeColor $color -Raw -TerminalType 'Code.exe')
			
			$DefaultBackColor = (ConvertTo-VtColorString -BackColor $color -Raw -TerminalType 'default')
			$PoShBackColor    = (ConvertTo-VtColorString -BackColor $color -Raw -TerminalType 'powershell.exe')
			$VsCodeBackColor  = (ConvertTo-VtColorString -BackColor $color -Raw -TerminalType 'Code.exe')
			
			$VtColorCodeArray += [PSCustomObject]@{
				ColorName = $color; 
				DefaultForeColor = $DefaultForeColor; 
				DefaultBackColor = $DefaultBackColor; 
				PoShForeColor = $PoShForeColor; 
				PoShBackColor = $PoShBackColor; 
				VsCodeForeColor = $VsCodeForeColor; 
				VsCodeBackColor = $VsCodeBackColor
			}
			
		} # End ForEach
		
		If ($BlackAndWhite) {
			
			$VtColorCodeArray = $VtColorCodeArray | Where-Object {$_.ColorName -match "Black|White"}
			
		} # End If ($BlackAndWhite)
		
		If ($Quiet) {
			Return $VtColorCodeArray
		} Else {
			$VtColorCodeArray | Format-Table -Property ColorName, @{
				Label = "DFC"
				Expression = {
					$colorstr = ConvertTo-VtColorString -Raw -ForeColor $_.ColorName -BackColor $_.ColorName -TerminalType 'Default'
					#https://stackoverflow.com/questions/20705102/how-to-colorise-powershell-output-of-format-table
					#https://docs.microsoft.com/en-us/windows/console/console-virtual-terminal-sequences#text-formatting
					# Escape key
					$e = [char]27
					# Magic string: VT escape sequences:
					# - ESC [ <n> m    Set the format of the screen and text as specified by <n>
					#    - 0    Default    Returns all attributes to the default state prior to modification
					#"$e[${colorstr}m$("       ")${e}[0m"
					"$e[${colorstr}m$("Test")${e}[0m"
				}
			}, DefaultForeColor, DefaultBackColor, @{
				Label = "PFC"
				Expression = {
					$colorstr = ConvertTo-VtColorString -Raw -ForeColor $_.ColorName -BackColor $_.ColorName -TerminalType 'powershell.exe'
					#https://stackoverflow.com/questions/20705102/how-to-colorise-powershell-output-of-format-table
					#https://docs.microsoft.com/en-us/windows/console/console-virtual-terminal-sequences#text-formatting
					# Escape key
					$e = [char]27
					# Magic string: VT escape sequences:
					# - ESC [ <n> m    Set the format of the screen and text as specified by <n>
					#    - 0    Default    Returns all attributes to the default state prior to modification
					#"$e[${colorstr}m$("       ")${e}[0m"
					"$e[${colorstr}m$("Test")${e}[0m"
				}
			}, PoShForeColor, PoShBackColor, @{
				Label = "VFC"
				Expression = {
					$colorstr = ConvertTo-VtColorString -Raw -ForeColor $_.ColorName -BackColor $_.ColorName -TerminalType 'Code.exe'
					#https://stackoverflow.com/questions/20705102/how-to-colorise-powershell-output-of-format-table
					#https://docs.microsoft.com/en-us/windows/console/console-virtual-terminal-sequences#text-formatting
					# Escape key
					$e = [char]27
					# Magic string: VT escape sequences:
					# - ESC [ <n> m    Set the format of the screen and text as specified by <n>
					#    - 0    Default    Returns all attributes to the default state prior to modification
					#"$e[${colorstr}m$("       ")${e}[0m"
					"$e[${colorstr}m$("Test")${e}[0m"
				}
			}, VsCodeForeColor, VsCodeBackColor
		} # End If/Else ($Quiet)
		
	
	} Else { # End ElseIf ($VtColors)
		If ($BlackAndWhite) {
			$Colors = $Colors | Where-Object {$_ -match "Black|White"}
		}
		Return $Colors
	}
	#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
} # End of Get-AllPowerShellColors function.
Set-Alias -Name 'Get-AllColors' -Value 'Get-AllPowerShellColors'
Set-Alias -Name 'Get-Colors' -Value 'Get-AllPowerShellColors'
Set-Alias -Name 'Get-ColorsList' -Value 'Get-AllPowerShellColors'
#-----------------------------------------------------------------------------------------------------------------------

#-----------------------------------------------------------------------------------------------------------------------
Function ConvertTo-VtColorString {
	<#
	.SYNOPSIS
	Converts a color string to an RGB VT color string.
	.DESCRIPTION
	Uses Virtual Terminal color codes, which greatly expands the range of colors available for use, and allows in-line text coloring.
	
	To find out if the type of PowerShell interface in use is compatible with Virtual Terminal colors, use the `(Get-AllPowerShellColors -ShowHostInfo).SupportsVirtualTerminal` command. These commands can also be used to view VT color compatibility: 
	 - `(Get-AllPowerShellColors -ShowHostInfo).SupportsVirtualTerminal`
	 - `Get-AllPowerShellColors -VtColors`
	 - `Get-AllPowerShellColors -List -VtColors`
	 - `Get-AllPowerShellColors -Grid -VtColors`
	
	How-to use:
	
	To activate the color codes, use magic opening and closing strings around the text you want to color. Or use -TextString parameter to add them automatically.
	
	# Magic strings:
	$colorstr = ConvertTo-VtColorString -ForeColor 'Green'
	#https://stackoverflow.com/questions/20705102/how-to-colorise-powershell-output-of-format-table
	#https://docs.microsoft.com/en-us/windows/console/console-virtual-terminal-sequences#text-formatting
	# Escape key
	$e = [char]27
	# Magic string: VT escape sequences:
	# - ESC [ <n> m    Set the format of the screen and text as specified by <n>
	#    - 0    Default    Returns all attributes to the default state prior to modification
	#"$e[${colorstr}m$("              ")${e}[0m"
	#"$e[${colorstr}m$("your text here")${e}[0m"
	
	.PARAMETER ForeColor
	Foreground color string. By default, uses the 16 different PowerShell colors. See `Get-AllPowerShellColors` command to list all colors.
	.PARAMETER BackColor
	Background color string. By default, uses the 16 different PowerShell colors. See `Get-AllPowerShellColors` command to list all colors.
	.PARAMETER TerminalType
	Pick the color set to use based on terminal type.
	
	-TerminalType "default"
	-TerminalType "powershell.exe"
	-TerminalType "Code.exe"
	-TerminalType "VSCodium.exe"
	.PARAMETER TextString
	Text string to return with magic string color code already applied. By default this function only returns the number code used in the magic string.
	.PARAMETER Raw
	For certain colors that seem to produce incorrect output in certain terminals, show that color as measured, instead of correcting it. See `Get-Help Get-AllPowerShellColors -Examples` command for examples of how some colors from different color sets can appear different or incorrect.
	.EXAMPLE
	ConvertTo-VtColorString -ForeColor Green
	ConvertTo-VtColorString -BackColor Green
	
	Demonstrating in-line colored text using magic strings:
	
	$colorstr = ConvertTo-VtColorString -ForeColor 'Green'
	# Escape key
	$e = [char]27
	# Magic string: VT escape sequences:
	# - ESC [ <n> m    Set the format of the screen and text as specified by <n>
	#    - 0    Default    Returns all attributes to the default state prior to modification
	#"$e[${colorstr}m$("              ")${e}[0m"
	#"$e[${colorstr}m$("your text here")${e}[0m"
	"your $e[${colorstr}m$("green text")${e}[0m here"
	.EXAMPLE
	ConvertTo-VtColorString -ForeColor Green -TextString 'green text' -Verbose
	
	Use the -TextString parameter and this function will auto-add the magic strings to the output. This can be used in-line with normal text in several ways.
	
	Here is the function called in-line with other Write-Host test:
	
	    Write-Host "The $(ConvertTo-VtColorString -ForeColor Green -TextString 'green text') can be printed in-line with normal text."
	
	In-line colored text saved as a var and printed later using Write-Host:
	
	    $InlineText = ConvertTo-VtColorString -ForeColor Green -TextString 'green text'
	    Write-Host "Here is some $InlineText printed to the terminal."
	.NOTES
	Version Notes:
	v1.1.0: 2024-08-04
	Added features: -TextString parameter for auto-adding the opening and closing magic strings in output.
	v1.0.0: 2022-01-12
	16 color selection based on PowerShell's defaults. Foreground and background colors supported. 3 different terminal color sets.
	
	Original repository:
	https://github.com/Kerbalnut/MiniTaskMang-PoSh
	https://github.com/Kerbalnut/MiniTaskMang-PoSh/blob/main/public/SaveLoadSync.ps1
	Copied to:
	https://github.com/Kerbalnut/SleepTimerPoSh
	https://github.com/Kerbalnut/SleepTimerPoSh/blob/main/Start-SleepTimer.ps1
	
	Development Notes:
	# Magic strings:
	$colorstr = $_.Default
	#https://stackoverflow.com/questions/20705102/how-to-colorise-powershell-output-of-format-table
	#https://docs.microsoft.com/en-us/windows/console/console-virtual-terminal-sequences#text-formatting
	# Escape key
	$e = [char]27
	# Magic string: VT escape sequences:
	# - ESC [ <n> m    Set the format of the screen and text as specified by <n>
	#    - 0    Default    Returns all attributes to the default state prior to modification
	#"$e[${colorstr}m$("       ")${e}[0m"
	#"$e[${colorstr}m$("       ")${e}[0m"
	.LINK
	https://github.com/Kerbalnut/MiniTaskMang-PoSh
	https://github.com/Kerbalnut/SleepTimerPoSh
	.LINK
	Get-AllPowerShellColors
	.LINK
	https://stackoverflow.com/questions/20705102/how-to-colorise-powershell-output-of-format-table
	https://docs.microsoft.com/en-us/windows/console/console-virtual-terminal-sequences#text-formatting
	#>
	[CmdletBinding()]
	Param(
		[Parameter(Position = 0, Mandatory = $False)]
		[String]$ForeColor,
		[Parameter(Position = 1, Mandatory = $False)]
		[String]$BackColor,
		[Parameter(Position = 2, Mandatory = $False)]
		[ValidateSet("default","powershell.exe","powershell","posh","Code.exe","vscode","VSCodium.exe","vscodium",IgnoreCase = $True)]
		[String]$TerminalType,
		[Parameter(Mandatory = $False)]
		[String]$TextString,
		[switch]$Raw
	)
	#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	Function ConvertTo-DefaultVtColorString($ForeColor,$BackColor) {
		If ($ForeColor -and "$ForeColor" -ne "") {
			switch ($ForeColor) {
				'Black' { $fcolor = "30"; break }
				'Blue' { $fcolor = "34"; break }
				'Cyan' { $fcolor = "36"; break }
				'DarkBlue' { $fcolor = "38;2;0;0;128"; break } # No analog to standardized vt colors: taken from powershell.exe terminal colors
				'DarkCyan' { $fcolor = "38;2;0;128;128"; break } # No analog to standardized vt colors: taken from powershell.exe terminal colors
				'DarkGray' { $fcolor = "38;2;128;128;128"; break } # No analog to standardized vt colors: taken from powershell.exe terminal colors
				'DarkGreen' { $fcolor = "38;2;0;128;0"; break } # No analog to standardized vt colors: taken from powershell.exe terminal colors
				'DarkMagenta' { $fcolor = "38;2;188;63;188"; break } # Standard in posh terminal broken: taken from vscode colors
				'DarkRed' { $fcolor = "38;2;128;0;0"; break } # No analog to standardized vt colors: taken from powershell.exe terminal colors
				'DarkYellow' { $fcolor = "38;2;229;229;16"; break } # Standard in posh terminal broken: taken from vscode colors
				'Gray' { $fcolor = "38;2;192;192;192"; break } # Standard in vscode console broken: taken from powershell.exe terminal colors
				'Green' { $fcolor = "32"; break }
				'Magenta' { $fcolor = "35"; break }
				'Red' { $fcolor = "31"; break }
				'White' { $fcolor = "37"; break }
				'Yellow' { $fcolor = "33"; break }
				Default {
					Write-Warning "Given -ForeColor parameter '$ForeColor' could not be resolved. Reverting to default."
					#0 	Default 	Returns all attributes to the default state prior to modification
					#39 	Foreground Default 	Applies only the foreground portion of the defaults (see 0)
					#49 	Background Default 	Applies only the background portion of the defaults (see 0)
					$fcolor = "39"
				}
			} # switch
		} # End If ($ForeColor)
		If ($BackColor -and "$BackColor" -ne "") {
			switch ($BackColor) {
				'Black' { $bcolor = "40"; break }
				'Blue' { $bcolor = "44"; break }
				'Cyan' { $bcolor = "46"; break }
				'DarkBlue' { $bcolor = "48;2;0;0;128"; break } # No analog to standardized vt colors: taken from powershell.exe terminal colors
				'DarkCyan' { $bcolor = "48;2;0;128;128"; break } # No analog to standardized vt colors: taken from powershell.exe terminal colors
				'DarkGray' { $bcolor = "48;2;128;128;128"; break } # No analog to standardized vt colors: taken from powershell.exe terminal colors
				'DarkGreen' { $bcolor = "48;2;0;128;0"; break } # No analog to standardized vt colors: taken from powershell.exe terminal colors
				'DarkMagenta' { $bcolor = "48;2;188;63;188"; break } # Standard in posh terminal broken: taken from vscode colors
				'DarkRed' { $bcolor = "48;2;128;0;0"; break } # No analog to standardized vt colors: taken from powershell.exe terminal colors
				'DarkYellow' { $bcolor = "48;2;229;229;16"; break } # Standard in posh terminal broken: taken from vscode colors
				'Gray' { $bcolor = "48;2;192;192;192"; break } # Standard in vscode console broken: taken from powershell.exe terminal colors
				'Green' { $bcolor = "42"; break }
				'Magenta' { $bcolor = "45"; break }
				'Red' { $bcolor = "41"; break }
				'White' { $bcolor = "47"; break }
				'Yellow' { $bcolor = "43"; break }
				Default {
					Write-Warning "Given -BackColor parameter '$BackColor' could not be resolved. Reverting to default."
					#0 	Default 	Returns all attributes to the default state prior to modification
					#39 	Foreground Default 	Applies only the foreground portion of the defaults (see 0)
					#49 	Background Default 	Applies only the background portion of the defaults (see 0)
					$bcolor = "49"
				}
			} # switch
		} # End If ($BackColor)
		If ($ForeColor -And $BackColor) {
			$VTColorString = $fcolor + ";" + $bcolor
		} Else {
			If ($ForeColor) {
				$VTColorString = $fcolor
			} ElseIf ($BackColor) {
				$VTColorString = $bcolor
			}
		}
		Return $VTColorString
	} # End Function ConvertTo-DefaultVtColorString
	#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	Function ConvertTo-PoshTerminalVtColorString($ForeColor,$BackColor) {
		If ($ForeColor -and "$ForeColor" -ne "") {
			switch ($ForeColor) {
				'Black' { $fcolor = "38;2;0;0;0"; break }
				'Blue' { $fcolor = "38;2;0;0;255"; break }
				'Cyan' { $fcolor = "38;2;0;255;255"; break }
				'DarkBlue' { $fcolor = "38;2;0;0;128"; break }
				'DarkCyan' { $fcolor = "38;2;0;128;128"; break }
				'DarkGray' { $fcolor = "38;2;128;128;128"; break }
				'DarkGreen' { $fcolor = "38;2;0;128;0"; break }
				'DarkMagenta' {
					If ($Raw) {
						$fcolor = "38;2;1;36;86"; break # Standard, (broken): appears as the same color of standard (blue) powershell terminal background
					} Else {
						$fcolor = "38;2;188;63;188"; break # taken from vscode colors
					}
				}
				'DarkRed' { $fcolor = "38;2;128;0;0"; break }
				'DarkYellow' {
					If ($Raw) {
						$fcolor = "38;2;238;237;240"; break # Standard, (broken): appears as a lighter gray than 'Gray', almost white but not quite
					} Else {
						$fcolor = "38;2;229;229;16"; break # taken from vscode colors
					}
				}
				'Gray' { $fcolor = "38;2;192;192;192"; break }
				'Green' { $fcolor = "38;2;0;255;0"; break }
				'Magenta' { $fcolor = "38;2;255;0;255"; break }
				'Red' { $fcolor = "38;2;255;0;0"; break }
				'White' { $fcolor = "38;2;255;255;255"; break }
				'Yellow' { $fcolor = "38;2;255;255;0"; break }
				Default {
					Write-Warning "Given -ForeColor parameter '$ForeColor' could not be resolved. Reverting to default."
					#0 	Default 	Returns all attributes to the default state prior to modification
					#39 	Foreground Default 	Applies only the foreground portion of the defaults (see 0)
					#49 	Background Default 	Applies only the background portion of the defaults (see 0)
					$fcolor = "39"
				}
			} # switch
		} # End If ($ForeColor)
		If ($BackColor -and "$BackColor" -ne "") {
			switch ($BackColor) {
				'Black' { $bcolor = "48;2;0;0;0"; break }
				'Blue' { $bcolor = "48;2;0;0;255"; break }
				'Cyan' { $bcolor = "48;2;0;255;255"; break }
				'DarkBlue' { $bcolor = "48;2;0;0;128"; break }
				'DarkCyan' { $bcolor = "48;2;0;128;128"; break }
				'DarkGray' { $bcolor = "48;2;128;128;128"; break }
				'DarkGreen' { $bcolor = "48;2;0;128;0"; break }
				'DarkMagenta' {
					If ($Raw) {
						$bcolor = "48;2;1;36;86"; break # Standard, (broken): appears as the same color of standard (blue) powershell terminal background
					} Else {
						$bcolor = "48;2;188;63;188"; break # taken from vscode colors
					}
				}
				'DarkRed' { $bcolor = "48;2;128;0;0"; break }
				'DarkYellow' {
					If ($Raw) {
						$bcolor = "48;2;238;237;240"; break # Standard, (broken): appears as a lighter gray than 'Gray', almost white but not quite
					} Else {
						$bcolor = "48;2;229;229;16"; break # taken from vscode colors
					}
				}
				'Gray' { $bcolor = "48;2;192;192;192"; break }
				'Green' { $bcolor = "48;2;0;255;0"; break }
				'Magenta' { $bcolor = "48;2;255;0;255"; break }
				'Red' { $bcolor = "48;2;255;0;0"; break }
				'White' { $bcolor = "48;2;255;255;255"; break }
				'Yellow' { $bcolor = "48;2;255;255;0"; break }
				Default {
					Write-Warning "Given -BackColor parameter '$BackColor' could not be resolved. Reverting to default."
					#0 	Default 	Returns all attributes to the default state prior to modification
					#39 	Foreground Default 	Applies only the foreground portion of the defaults (see 0)
					#49 	Background Default 	Applies only the background portion of the defaults (see 0)
					$bcolor = "49"
				}
			} # switch
		} # End If ($BackColor)
		If ($ForeColor -And $BackColor) {
			$VTColorString = $fcolor + ";" + $bcolor
		} Else {
			If ($ForeColor) {
				$VTColorString = $fcolor
			} ElseIf ($BackColor) {
				$VTColorString = $bcolor
			}
		}
		Return $VTColorString
	} # End Function ConvertTo-PoshTerminalVtColorString
	#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	Function ConvertTo-VscodeVtColorString($ForeColor,$BackColor) {
		If ($ForeColor -and "$ForeColor" -ne "") {
			switch ($ForeColor) {
				'Black' { $fcolor = "38;2;0;0;0"; break }
				'Blue' { $fcolor = "38;2;59;142;234"; break }
				'Cyan' { $fcolor = "38;2;41;184;219"; break }
				'DarkBlue' { $fcolor = "38;2;0;0;128"; break }
				'DarkCyan' { $fcolor = "38;2;0;128;128"; break }
				'DarkGray' { $fcolor = "38;2;128;128;128"; break }
				'DarkGreen' { $fcolor = "38;2;0;128;0"; break }
				'DarkMagenta' { $fcolor = "38;2;188;63;188"; break }
				'DarkRed' { $fcolor = "38;2;128;0;0"; break }
				'DarkYellow' { $fcolor = "38;2;229;229;16"; break }
				'Gray' {
					If ($Raw) {
						$fcolor = "38;2;229;229;229"; break # Standard, (broken): appears exact same as vscode white
					} Else {
						$fcolor = "38;2;192;192;192"; break # taken from powershell.exe terminal colors
					}
				}
				'Green' { $fcolor = "38;2;35;209;139"; break }
				'Magenta' { $fcolor = "38;2;214;112;214"; break }
				'Red' { $fcolor = "38;2;241;76;76"; break }
				'White' { $fcolor = "38;2;229;229;229"; break }
				'Yellow' { $fcolor = "38;2;245;245;67"; break }
				Default {
					Write-Warning "Given -ForeColor parameter '$ForeColor' could not be resolved. Reverting to default."
					#0 	Default 	Returns all attributes to the default state prior to modification
					#39 	Foreground Default 	Applies only the foreground portion of the defaults (see 0)
					#49 	Background Default 	Applies only the background portion of the defaults (see 0)
					$fcolor = "39"
				}
			} # switch
		} # End If ($ForeColor)
		If ($BackColor -and "$BackColor" -ne "") {
			switch ($BackColor) {
				'Black' { $bcolor = "48;2;30;30;30"; break }
				'Blue' { $bcolor = "48;2;59;142;234"; break }
				'Cyan' { $bcolor = "48;2;41;184;219"; break }
				'DarkBlue' { $bcolor = "48;2;0;0;128"; break }
				'DarkCyan' { $bcolor = "48;2;0;128;128"; break }
				'DarkGray' { $bcolor = "48;2;128;128;128"; break }
				'DarkGreen' { $bcolor = "48;2;0;128;0"; break }
				'DarkMagenta' { $bcolor = "48;2;188;63;188"; break }
				'DarkRed' { $bcolor = "48;2;128;0;0"; break }
				'DarkYellow' { $bcolor = "48;2;229;229;16"; break }
				'Gray' {
					If ($Raw) {
						$bcolor = "48;2;229;229;229"; break # Standard, (broken): appears exact same as vscode white
					} Else {
						$bcolor = "48;2;192;192;192"; break # taken from powershell.exe terminal colors
					}
				}
				'Green' { $bcolor = "48;2;35;209;139"; break }
				'Magenta' { $bcolor = "48;2;214;112;214"; break }
				'Red' { $bcolor = "48;2;241;76;76"; break }
				'White' { $bcolor = "48;2;229;229;229"; break }
				'Yellow' { $bcolor = "48;2;245;245;67"; break }
				Default {
					Write-Warning "Given -BackColor parameter '$BackColor' could not be resolved. Reverting to default."
					#0 	Default 	Returns all attributes to the default state prior to modification
					#39 	Foreground Default 	Applies only the foreground portion of the defaults (see 0)
					#49 	Background Default 	Applies only the background portion of the defaults (see 0)
					$bcolor = "49"
				}
			} # switch
		} # End If ($BackColor)
		If ($ForeColor -And $BackColor) {
			$VTColorString = $fcolor + ";" + $bcolor
		} Else {
			If ($ForeColor) {
				$VTColorString = $fcolor
			} ElseIf ($BackColor) {
				$VTColorString = $bcolor
			}
		}
		Return $VTColorString
	} # End Function ConvertTo-VscodeVtColorString
	#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	$SubFunctionParams = @{}
	If ($ForeColor -and "$ForeColor" -ne "") {
		Write-Verbose "-ForeColor activated: `"$ForeColor`""
		$SubFunctionParams += @{ForeColor = $ForeColor}
	}
	If ($BackColor -and "$BackColor" -ne "") {
		Write-Verbose "-BackColor activated: `"$BackColor`""
		$SubFunctionParams += @{BackColor = $BackColor}
	}
	#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	If ($TerminalType -ieq "powershell" -Or $TerminalType -ieq "posh") {
		$TerminalType = "powershell.exe"
	}
	If ($TerminalType -ieq "vscode") {
		$TerminalType = "Code.exe"
	}
	If ($TerminalType -ieq "vscodium") {
		$TerminalType = "VSCodium.exe"
	}
	switch ($TerminalType) {
		'default' {
			Write-Verbose "-TerminalType: Default colors chosen. (Explicit)"
			$VTColorString = ConvertTo-DefaultVtColorString @SubFunctionParams
		} # 'default'
		'powershell.exe' {
			Write-Verbose "-TerminalType: powershell.exe terminal colors chosen."
			$VTColorString = ConvertTo-PoshTerminalVtColorString @SubFunctionParams
		} # 'powershell.exe'
		'Code.exe' {
			Write-Verbose "-TerminalType: vscode (Code.exe) console colors chosen."
			$VTColorString = ConvertTo-VscodeVtColorString @SubFunctionParams
		} # 'Code.exe'
		'VSCodium.exe' {
			Write-Verbose "-TerminalType: VSCodium.exe console colors chosen."
			$VTColorString = ConvertTo-VscodeVtColorString @SubFunctionParams
		} # 'VSCodium.exe'
		Default {
			Write-Verbose "-TerminalType: Default colors chosen. (Unspecified, failover to default)"
			$VTColorString = ConvertTo-DefaultVtColorString @SubFunctionParams
		} # Default
	} # switch
	#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	# Magic strings:
	#$colorstr = $_.Default
	#https://stackoverflow.com/questions/20705102/how-to-colorise-powershell-output-of-format-table
	#https://docs.microsoft.com/en-us/windows/console/console-virtual-terminal-sequences#text-formatting
	# Escape key
	#$e = [char]27
	# Magic string: VT escape sequences:
	# - ESC [ <n> m    Set the format of the screen and text as specified by <n>
	#    - 0    Default    Returns all attributes to the default state prior to modification
	#"$e[${colorstr}m$("       ")${e}[0m"
	#"$e[${colorstr}m$("       ")${e}[0m"
	If ($TextString -and "$TextString" -ne "") {
		Write-Verbose "-TextString: Generate magic string for coloring text '$TextString'"
		# Magic strings:
		$colorstr = $VTColorString
		#https://stackoverflow.com/questions/20705102/how-to-colorise-powershell-output-of-format-table
		#https://docs.microsoft.com/en-us/windows/console/console-virtual-terminal-sequences#text-formatting
		# Escape key
		$e = [char]27
		# Magic string: VT escape sequences:
		# - ESC [ <n> m    Set the format of the screen and text as specified by <n>
		#    - 0    Default    Returns all attributes to the default state prior to modification
		#"$e[${colorstr}m$("       ")${e}[0m"
		#"$e[${colorstr}m$("       ")${e}[0m"
		#Return "$e[${colorstr}m$("$TextString")${e}[0m"
		$VTColorString = "$e[${colorstr}m$("$TextString")${e}[0m"
	}
	#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	Return $VTColorString
} # End of ConvertTo-VtColorString function.
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

#
#>

#-----------------------------------------------------------------------------------------------------------------------
Function Set-DefaultMTMProjectPath {
	<#
	.SYNOPSIS
	Single-line summary.
	.DESCRIPTION
	Multiple paragraphs describing in more detail what the function is, what it does, how it works, inputs it expects, and outputs it creates.
	.PARAMETER ProjectPath
	.PARAMETER PathToModuleTemplate
	.NOTES
	Some extra info about this function, like it's origins, what module (if any) it's apart of, and where it's from.
	
	Maybe some original author credits as well.
	#>
	[Alias("Set-MTMPath")]
	#Requires -Version 3
	[CmdletBinding()]
	Param(
		[Parameter(Mandatory = $False, Position = 0,
		           ValueFromPipeline = $True, 
		           ValueFromPipelineByPropertyName = $True)]
		[Alias('Path')]
		[String]$ProjectPath,
		
		[String]$PathToModuleTemplate = "MTM_GetProjPath_template.psm1"
		
	)
	#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	$CommonParameters = @{
		Verbose = [System.Management.Automation.ActionPreference]$VerbosePreference
		Debug = [System.Management.Automation.ActionPreference]$DebugPreference
	}
	#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	
	Write-Verbose "Check that project path exists."
	
	$DefaultProjectLocation = "Projects\Default Project"
	
	If (!($ProjectPath)) {
		$ProjectPath = Split-Path -Path (Get-LocalPath) -Parent
		$ProjectPath = Join-Path -Path $ProjectPath -ChildPath $DefaultProjectLocation
		Write-Warning "No -ProjectPath parameter provided. Default path selected: `"$ProjectPath`""
		Write-Debug "No -ProjectPath parameter provided. Default path selected: `"$ProjectPath`""
		Try {
			$null = MkDir $ProjectPath
		} Catch {
			Write-Error "Problem with creating default Project folder: `"$ProjectPath`""
			Throw "Problem with creating default Project folder: `"$ProjectPath`""
		}
		Write-Verbose "New default -ProjectPath created: `"$ProjectPath`""
	}
	
	If (!(Test-Path -Path $ProjectPath)) {
		Write-Warning "Given -ProjectPath location does not exist: `"$ProjectPath`""
		Write-Error "Given -ProjectPath location does not exist: `"$ProjectPath`""
		Throw "Given -ProjectPath location does not exist: `"$ProjectPath`""
	}
	
	#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	
	Write-Verbose "Process module template path:"
	
	Write-Verbose "Remove _Template keyword: Separate extension, remove keyword, concat extension."
	
	Write-Verbose "Separate Extension:"
	
	
	#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	
	Write-Verbose "Replace placeholder vars:"
	
	Write-Verbose "Get contents of `"$PathToModuleTemplate`", find-and-replace vars, "
	
	Get-Content -Path $PathToModuleTemplate
	
	
	#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	
	
	
	#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	
	
	
	#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	Return $a
} # End of Set-DefaultMTMProjectPath function.
Set-Alias -Name 'Set-MTMPath' -Value 'Set-DefaultMTMProjectPath'
#-----------------------------------------------------------------------------------------------------------------------

#-----------------------------------------------------------------------------------------------------------------------
Function Get-LocalPath {
	<#
	.SYNOPSIS
	Returns the local path of this function.
	.DESCRIPTION
	
	.EXAMPLE
	Get-LocalPath -Verbose
	.NOTES
	Created: 2022-03-06
	Author: Kerbalnut
	#>
	#Requires -Version 3
	[CmdletBinding()]
	Param()
	#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	$CommonParameters = @{
		Verbose = [System.Management.Automation.ActionPreference]$VerbosePreference
		Debug = [System.Management.Automation.ActionPreference]$DebugPreference
	}
	#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	
	# Script name (including extension)
	$ScriptName = $MyInvocation.MyCommand.Name
	Write-Verbose "Script name: `n`"$ScriptName`""
	
	# Script dir (home directory of script)
	Write-Verbose "Script home directory:"
	#https://stackoverflow.com/questbions/801967/how-can-i-find-the-source-path-of-an-executing-script/6985381#6985381
	If ($DebugPreference -ne 'SilentlyContinue') {
		Write-Debug "'Split-Path `$script:MyInvocation.MyCommand.Path' Generates an error, 'Path' is null. Most likely `$script is null."
		$ScriptDir = Split-Path $script:MyInvocation.MyCommand.Path
		Write-Verbose "$ScriptDir"
		
		Write-Debug "'Split-Path -parent `$MyInvocation.MyCommand.Definition' Actually returns the entire executable script:"
		$ScriptDir = Split-Path -parent $MyInvocation.MyCommand.Definition # PoSh v2 compatible - thanks to https://stackoverflow.com/questions/5466329/whats-the-best-way-to-determine-the-location-of-the-current-powershell-script
		Write-Verbose "$ScriptDir"
	}
	$ScriptDir = $PSScriptRoot # PoSh v3 compatible - This is an automatic variable set to the current file's/module's directory
	Write-Verbose "`"$ScriptDir`""
	
	If ($DebugPreference -ne 'SilentlyContinue') {
		Write-Debug "'`$MyInvocation.MyCommand.Path' Returns null:"
		# Script path (full file path & name & extension of currently running script)
		$ScriptPath = $MyInvocation.MyCommand.Path
		Write-Verbose "Script full path:"
		Write-Verbose "`"$ScriptPath`""
	}
	
	#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	Return $ScriptDir
} # End of Get-LocalPath function.
#-----------------------------------------------------------------------------------------------------------------------

#-----------------------------------------------------------------------------------------------------------------------
Function Get-PartialOrFullPath {
	<#
	.SYNOPSIS
	Single-line summary.
	.DESCRIPTION
	Multiple paragraphs describing in more detail what the function is, what it does, how it works, inputs it expects, and outputs it creates.
	.NOTES
	Some extra info about this function, like it's origins, what module (if any) it's apart of, and where it's from.
	
	Maybe some original author credits as well.
	#>
	[Alias("Get-PartialPath")]
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
	$CommonParameters = @{
		Verbose = [System.Management.Automation.ActionPreference]$VerbosePreference
		Debug = [System.Management.Automation.ActionPreference]$DebugPreference
	}
	#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	
	# Check if given BackupFile path is a filename, or full path.
	$PathPrefix = Split-Path -Path $BackupFile -Parent
	
	# Check if given $BackupFile string is a file
	$PartialPath = $False
	If ($PathPrefix -eq "." -Or $PathPrefix -eq "\" -Or $PathPrefix -eq "" -Or $null -eq $PathPrefix) {
		$PartialPath = $True
		Write-Verbose "Partial Path detected: $PartialPath"
	}
	
	If ($PartialPath) {
		# If BackupFile filename starts with a period . remove it: E.g. ".\Backup file name.log" to "\Backup file name.log"
		$BackupFile = $BackupFile -replace '^\.', ''
		# RegEx: ^\.
		#    ^   Asserts position at start of a line.
		#    \.  Matches the period . character literally. (Backslash \ is the escape character)
		
		# Get current execution path, in order to combine with given BackupFile filename to get a full file path.
		$ScriptPath = $MyInvocation.MyCommand.Path
		# If being run via F8 'Run Selection' method, then $MyInvocation.MyCommand.Definition will return entire script being executed, and will probably make Split-Path fail.
		#$ScriptDir = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent # PoSh v2 compatible - thanks to https://stackoverflow.com/questions/5466329/whats-the-best-way-to-determine-the-location-of-the-current-powershell-script
		$WorkingDirectory = Get-Location
		Write-Verbose "`$ScriptPath = $ScriptPath"
		#Write-Verbose "`$ScriptDir = $ScriptDir"
		Write-Verbose "`$WorkingDirectory = $WorkingDirectory"
		
		# Combine current execution path with given BackupFile filename to get a full file path:
		$BackupFile = Join-Path -Path $WorkingDirectory -ChildPath $BackupFile
	}
	
	# Get file extension:
	#https://www.tutorialspoint.com/how-to-get-the-file-extension-using-powershell
	$Method = 0
	switch ($Method) {
		0 {
			$FileExtension = [System.IO.Path]::GetExtension($BackupFile)
			# .txt
			# .zip
			Write-Verbose "Get file extension method $($Method): [System.IO.Path]::GetExtension(`$BackupFile)`n`t- `$FileExtension = `"$FileExtension`""
		}
		1 {
			$FileExtension = ((Split-Path $BackupFile -Leaf).Split('.'))[1]
			# txt
			# zip
			Write-Verbose "Get file extension method $($Method): ((Split-Path `$BackupFile -Leaf).Split('.'))[1]`n`t- `$FileExtension = `"$FileExtension`""
		}
		2 {
			$FileExtension = (Get-ChildItem $BackupFile).Extension
			# .txt
			# .zip
			Write-Verbose "Get file extension method $($Method): (Get-ChildItem `$BackupFile).Extension`n`t- `$FileExtension = `"$FileExtension`""
		}
		3 {
			$FileExtension = (Get-Item $BackupFile).Extension
			# .txt
			# .zip
			Write-Verbose "Get file extension method $($Method): (Get-Item `$BackupFile).Extension`n`t- `$FileExtension = `"$FileExtension`""
		}
		Default {Throw "Please select a method (`$Method = `'$Method`') for getting PowerShell path extension."}
	}
	Write-Verbose "`$FileExtension = `"$FileExtension`""
	
	# If given filename doesn't have an extension for some reason, assign one.
	If ($FileExtension -eq '' -Or $null -eq $FileExtension) {
		$FileExtension = ".txt"
		Write-Verbose "`$FileExtension = `"$FileExtension`" (none detected, defaulting to .txt)"
		$BackupFile = $BackupFile + $FileExtension
	}
	
	Write-Verbose "Before any file (backup) operations."
	# If BackupFile still exists, try to rename it to BackupFile_old or something:
	If ((Test-Path -Path $BackupFile)) {
		Write-Warning "`$BackupFile already exists: `"$BackupFile`""
		# Generate BackupFile_old filepath:
		If ($FileExtension -ne '' -And $null -ne $FileExtension) {
			# Remove file extension:
			$NoExtension = $BackupFile -replace '\.\w+$', ''
			# RegEx: \.\w+$
			#    \.  Matches the period . character literally. (Backslash \ is the escape character)
			#    \w+ Matches any word character (equivalent to [a-zA-Z0-9_]), and the plus + modifier matches between one and unlimited times (Greedy).
			#    $   Asserts position at the end of a line.
		}
		
		$NewName = $NoExtension + "_old" + $FileExtension
		
		Write-Verbose "Renaming existing file to: `"$NewName`""
		# Check if this BackupFile_old file already exists:
		If ((Test-Path -Path $NewName)) {
			Write-Warning "Old backup file already exists: `"$NewName`""
			Write-Warning "Removing old backup file before generating new one: `"$NewName`""
			Write-Debug "Removing old backup file before generating new one: `"$NewName`""
			Remove-Item -Path $NewName
			Start-Sleep -Milliseconds 150
		}
		Rename-Item -Path $BackupFile -NewName $NewName
		Start-Sleep -Milliseconds 150
	}
	#New-Item -Path $BackupFile -Value (Get-Date -Format "o")
	$NewItemResults = New-Item -Path $BackupFile
	Add-Content -Path $BackupFile -Value (Get-Date -Format "o")
	#Add-Content -Path $BackupFile -Value "`n"
	Add-Content -Path $BackupFile -Value (Get-Date)
	Add-Content -Path $BackupFile -Value "`n"
	
	Write-Verbose "Finished verifying `$BackupFile path: `"$BackupFile`""
	
	
	#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	Return
} # End of Get-PartialOrFullPath function.
Set-Alias -Name 'Get-PartialPath' -Value 'Get-PartialOrFullPath'
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
	Get-MyTasks
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
		[Parameter(Mandatory = $False, Position = 0,
		           ValueFromPipeline = $True, 
		           ValueFromPipelineByPropertyName = $True,
		           HelpMessage = "Path to MiniTaskMang project folder")]
		[ValidateNotNullOrEmpty()]
		[Alias('Path')]
		[String]$ProjectPath,
		
		[Parameter(ValueFromPipelineByPropertyName = $True)]
		[ValidateSet("default", "powershell.exe", "Code.exe", "VSCodium.exe")]
		[String]$TerminalTypeColors = 'default'
	)
	#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	If ($null -eq $ProjectPath -Or !($ProjectPath) -Or $ProjectPath -eq "") {
		$ProjectPath = Get-DefaultMTMProjectPath
	}
	#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	
	$TerminalType = $TerminalTypeColors
	
	#$ProjectPath = "$Home\Documents\GitHub\MiniTaskMang-PoSh\Test Project"
	
	#$ProjectPath = $Path
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
	
	If ($DebugPreference -ne 'SilentlyContinue') {
		$Tasks | Format-Table
		$Contexts | Format-Table
		$Statuses | Format-Table
	}
	
	#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	
	#https://stackoverflow.com/questions/20705102/how-to-colorise-powershell-output-of-format-table
	
	#https://docs.microsoft.com/en-us/windows/console/console-virtual-terminal-sequences#text-formatting
	
	<#
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
	#>
	
	<#
	Write-PSObject $servers -MatchMethod Exact -Column "Manufacture" -Value "HP" -ValueForeColor Yellow -ValueBackColor Red -RowForeColor White -RowBackColor Blue;
	#>
	
	#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	
	$Tasks | Format-Table -Property ID, Name, ParentProjectID, @{
		Label = "ContextID"
		Expression = {
			ForEach ($context in $Contexts) {
				If ($context.ID -eq ($_.ContextID)) {
					$ForegroundColorSel = $context.ForeColor
					$BackgroundColorSel = $context.BackColor
					$ContextSelName = $context.Name
				}
			}
			
			$colorstr = ConvertTo-VtColorString -ForeColor $ForegroundColorSel -BackColor $BackgroundColorSel -TerminalType $TerminalType
			
			#https://stackoverflow.com/questions/20705102/how-to-colorise-powershell-output-of-format-table
			#https://docs.microsoft.com/en-us/windows/console/console-virtual-terminal-sequences#text-formatting
			# Escape key
			$e = [char]27
			# Magic string: VT escape sequences:
			# - ESC [ <n> m    Set the format of the screen and text as specified by <n>
			#    - 0    Default    Returns all attributes to the default state prior to modification
			"$e[${colorstr}m$($ContextSelName)${e}[0m"
		}
	}, @{
		Label = "StatusID"
		Expression = {
			ForEach ($status in $Statuses) {
				If ($status.ID -eq ($_.StatusID)) {
					$ForegroundColorSel = $status.ForeColor
					$BackgroundColorSel = $status.BackColor
					$StatusSelName = $status.Name
				}
			}
			
			$colorstr = ConvertTo-VtColorString -ForeColor $ForegroundColorSel -BackColor $BackgroundColorSel -TerminalType $TerminalType
			
			#https://stackoverflow.com/questions/20705102/how-to-colorise-powershell-output-of-format-table
			#https://docs.microsoft.com/en-us/windows/console/console-virtual-terminal-sequences#text-formatting
			# Escape key
			$e = [char]27
			# Magic string: VT escape sequences:
			# - ESC [ <n> m    Set the format of the screen and text as specified by <n>
			#    - 0    Default    Returns all attributes to the default state prior to modification
			"$e[${colorstr}m$($StatusSelName)${e}[0m"
		}
	}, CreationDate, LastUpdateDate, CompletionDate, DeletionDate
	
	#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	
	Return
} # End of Get-MyTasks function.
Set-Alias -Name 'Get-Tasks' -Value 'Get-MyTasks'
Set-Alias -Name 'Get-MyProgress' -Value 'Get-MyTasks'
Set-Alias -Name 'Get-MyItems' -Value 'Get-MyTasks'
Set-Alias -Name 'Get-MyProgressItems' -Value 'Get-MyTasks'
#-----------------------------------------------------------------------------------------------------------------------

#-----------------------------------------------------------------------------------------------------------------------
Function Get-Contexts {
	<#
	.SYNOPSIS
	Print list of MTM (MiniTaskMang) contexts from default project.
	.DESCRIPTION
	Desc
	.NOTES
	Notes
	.EXAMPLE
	Get-Contexts
	.EXAMPLE
	Get-Contexts -Path "$Home\Documents\GitHub\MiniTaskMang-PoSh\Test Project"
	
	$ProjectPath = "$Home\Documents\GitHub\MiniTaskMang-PoSh\Test Project"
	.LINK
	https://stackoverflow.com/questions/20705102/how-to-colorise-powershell-output-of-format-table
	https://docs.microsoft.com/en-us/windows/console/console-virtual-terminal-sequences#text-formatting
	#>
	[Alias('Get-MyContexts')]
	[CmdletBinding()]
	Param(
		[Parameter(Mandatory = $False, Position = 0,
		           ValueFromPipeline = $True, 
		           ValueFromPipelineByPropertyName = $True,
		           HelpMessage = "Path to MiniTaskMang project folder")]
		[ValidateNotNullOrEmpty()]
		[Alias('Path')]
		[String]$ProjectPath,
		
		[Parameter(ValueFromPipelineByPropertyName = $True)]
		[ValidateSet("default", "powershell.exe", "Code.exe", "VSCodium.exe")]
		[String]$TerminalTypeColors = 'default'
	)
	#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	If ($null -eq $ProjectPath -Or !($ProjectPath) -Or $ProjectPath -eq "") {
		$ProjectPath = Get-DefaultMTMProjectPath
	}
	#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	$TerminalType = $TerminalTypeColors
	
	$ContextsTableName = "Contexts"
	
	$FileExtension = ".csv"
	$ContextsFileName = $ContextsTableName + $FileExtension
	$ContextsPath = Join-Path -Path $ProjectPath -ChildPath $ContextsFileName
	
	$Contexts = Import-Csv -Path $ContextsPath
	
	If ($DebugPreference -ne 'SilentlyContinue') {
		$Contexts | Format-Table
	}
	
	#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	
	#https://stackoverflow.com/questions/20705102/how-to-colorise-powershell-output-of-format-table
	
	#https://docs.microsoft.com/en-us/windows/console/console-virtual-terminal-sequences#text-formatting
	
	<#
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
	#>
	
	<#
	Write-PSObject $servers -MatchMethod Exact -Column "Manufacture" -Value "HP" -ValueForeColor Yellow -ValueBackColor Red -RowForeColor White -RowBackColor Blue;
	#>
	
	#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	
	$Contexts = $Contexts | Where-Object -Property Enabled -eq True
	
	#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	
	$Contexts | Format-Table -Property ID, @{
		Label = "Name"
		Expression = {
			ForEach ($context in $Contexts) {
				If ($context.ID -eq ($_.ID)) {
					$ForegroundColorSel = $context.ForeColor
					$BackgroundColorSel = $context.BackColor
					$ContextSelName = $context.Name
				}
			}
			
			$colorstr = ConvertTo-VtColorString -ForeColor $ForegroundColorSel -BackColor $BackgroundColorSel -TerminalType $TerminalType
			
			#https://stackoverflow.com/questions/20705102/how-to-colorise-powershell-output-of-format-table
			#https://docs.microsoft.com/en-us/windows/console/console-virtual-terminal-sequences#text-formatting
			# Escape key
			$e = [char]27
			# Magic string: VT escape sequences:
			# - ESC [ <n> m    Set the format of the screen and text as specified by <n>
			#    - 0    Default    Returns all attributes to the default state prior to modification
			"$e[${colorstr}m$($ContextSelName)${e}[0m"
		}
	}, @{
		Label = "Enabled"
		Expression = {
			
			If ($_.Enabled -ieq "True") {
				$colorstr = ConvertTo-VtColorString -ForeColor $ForegroundColorSel -BackColor $BackgroundColorSel -TerminalType $TerminalType
			} Else {
				$colorstr = ConvertTo-VtColorString -ForeColor $ForegroundColorSel -BackColor $BackgroundColorSel -TerminalType $TerminalType
			}
			
			#https://stackoverflow.com/questions/20705102/how-to-colorise-powershell-output-of-format-table
			#https://docs.microsoft.com/en-us/windows/console/console-virtual-terminal-sequences#text-formatting
			# Escape key
			$e = [char]27
			# Magic string: VT escape sequences:
			# - ESC [ <n> m    Set the format of the screen and text as specified by <n>
			#    - 0    Default    Returns all attributes to the default state prior to modification
			"$e[${colorstr}m$($StatusSelName)${e}[0m"
		}
	}, CreationDate, LastUpdateDate, CompletionDate, DeletionDate
	
	#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	
	Return
} # End of Get-Contexts function.
Set-Alias -Name 'Get-MyContexts' -Value 'Get-Contexts'
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
				   ValueFromPipelineByPropertyName = $True, 
				   HelpMessage = "Enter new Task name")]
		[ValidateNotNullOrEmpty()]
		[Alias('Task','Name','n')]
		[String]$TaskName,
		
		[Parameter(Mandatory = $False, 
				   Position = 1, 
				   ValueFromPipelineByPropertyName = $True)]
		[ValidateNotNullOrEmpty()]
		[Alias('Category','c')]
		[String]$Context,
		
		[Parameter(Mandatory = $False, ValueFromPipelineByPropertyName = $True)]
		[Alias('Path')]
		[String]$ProjectPath
		
	)
	#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	If ($null -eq $ProjectPath -Or !($ProjectPath) -Or $ProjectPath -eq "") {
		$ProjectPath = Get-DefaultMTMProjectPath
	}
	#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	
	If (!($Context)) {
		
	}
	
	
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
		[Parameter(Mandatory = $False, Position = 0,
		           ValueFromPipeline = $True, 
		           ValueFromPipelineByPropertyName = $True,
		           HelpMessage = "Path to MiniTaskMang project folder")]
		[ValidateNotNullOrEmpty()]
		[Alias('Path')]
		[String]$ProjectPath
		
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
		[Parameter(Mandatory = $False, Position = 0,
		           ValueFromPipeline = $True, 
		           ValueFromPipelineByPropertyName = $True,
		           HelpMessage = "Path to MiniTaskMang project folder")]
		[ValidateNotNullOrEmpty()]
		[Alias('Path')]
		[String]$ProjectPath
		
	)
	
	Return
} # End of Get-MyTaskStatus function.
Set-Alias -Name 'Get-MyStatus' -Value 'Get-MyTaskStatus'
Set-Alias -Name 'Get-TaskStatus' -Value 'Get-MyTaskStatus'
#-----------------------------------------------------------------------------------------------------------------------


#-----------------------------------------------------------------------------------------------------------------------
Function Select-Task {
	<#
	.SYNOPSIS
	Create a new action item in default MTM (MiniTaskMang) project.
	.DESCRIPTION
	.NOTES
	#>
	#Requires -Version 3
	[CmdletBinding()]
	Param(
		[Parameter(Mandatory = $False, Position = 0, 
		           ValueFromPipeline = $True, 
		           ValueFromPipelineByPropertyName = $True, 
		           HelpMessage = "Path to MiniTaskMang project folder")]
		[ValidateNotNullOrEmpty()]
		[Alias('Path')]
		[String]$ProjectPath,
		
		[Parameter(Mandatory = $True, Position = 1, 
				   ValueFromPipelineByPropertyName = $True)]
		[ValidateNotNullOrEmpty()]
		[Alias('Task','ID','t','i')]
		[String]$TaskID
	)
	#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	If ($null -eq $ProjectPath -Or !($ProjectPath) -Or $ProjectPath -eq "") {
		$ProjectPath = Get-DefaultMTMProjectPath
	}
	#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	
	
	
	#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	Return
} # End of Select-Task function.
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
	#[CmdletBinding()]
	[CmdletBinding(DefaultParameterSetName = 'None')]
	Param(
		[Parameter(Mandatory = $True, Position = 0, 
		           ValueFromPipeline = $True, 
		           ValueFromPipelineByPropertyName = $True, 
		           HelpMessage = "Path to ...", 
		           ParameterSetName = "Path")]
		[ValidateNotNullOrEmpty()]
		[ValidateSet("default", "powershell.exe", "Code.exe", "VSCodium.exe")]
		[Alias('ProjectPath','p')]
		[String]$Path
		
	)
	#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	$CommonParameters = @{
		Verbose = [System.Management.Automation.ActionPreference]$VerbosePreference
		Debug = [System.Management.Automation.ActionPreference]$DebugPreference
	}
	#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	
	
	#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	Return
} # End of New-TaskTrackingInitiativeTEST function.
Set-Alias -Name 'New-ProjectInitTEST' -Value 'New-TaskTrackingInitiativeTEST'
#-----------------------------------------------------------------------------------------------------------------------


