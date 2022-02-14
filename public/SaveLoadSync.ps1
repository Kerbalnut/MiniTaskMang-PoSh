
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
	Returns available PowerShell colors.
	.DESCRIPTION
	Prints complete list of every available PowerShell color with Foreground and Background examples.
	.PARAMETER List
	Prints a complete list of different ForeGround and BackGround color examples. Useful for choosing multiple fore/back color pairs.
	
	Not compatible with -ColorGrid parameter.
	.PARAMETER AddColorLabels
	Adds non-color-formatted labels to -ColorList output.
	
	For a standard-width PowerShell terminal, this extra string length will overflow each line of printed output, so usually requires a wider than normal terminal width for formatted output.
	.PARAMETER Grid
	Returns an array object with details about color options, and few color examples.
	
	Not compatible with -ColorList parameter.
	.PARAMETER VtColors
	Show addiitional options for Virtual Terminal colors.
	.PARAMETER Quiet
	Returns complete list of color names only. No other Write-Host output is printed to console. Overrides other switches that produce host/terminal output. Pipeline output will still be produced.
	.EXAMPLE
	Get-AllPowerShellColors
	
	Lists available PowerShell colors.
	.EXAMPLE
	(Get-AllPowerShellColors -Quiet).Count
	
	Returns number of available PowerShell colors.
	.EXAMPLE
	[string[]](Get-AllPowerShellColors -Quiet) | Sort-Object
	
	Returns list of available named PowerShell colors, in alphabetical order.
	.EXAMPLE
	Get-AllPowerShellColors -Quiet -Alphabetic:$False
	
	Do not produce alphabetic output. This switch is on by default, so this syntax is required to explicitly turn it off.
	.EXAMPLE
	Get-AllPowerShellColors -List
	
	Alias for:
	Get-AllPowerShellColors -ColorList
	.EXAMPLE
	Get-AllPowerShellColors -Grid
	
	Prints to console a list of every powershell color applied in every variety of Foreground color and Background color combination. Traditionally, there are 16 available colors, so this switch generates a nice-looking grid on standard-width PowerShell terminal.
	
	Alias for:
	Get-AllPowerShellColors -ColorGrid
	.EXAMPLE
	Get-AllPowerShellColors -ColorGrid -BlackAndWhite
	.EXAMPLE
	Get-AllPowerShellColors -VtColors
	.EXAMPLE
	Get-AllPowerShellColors -VtColors -ColorGrid
	.EXAMPLE
	Get-AllPowerShellColors -VtColors -List | Format-Table
	.NOTES
	.LINK
	https://stackoverflow.com/questions/20541456/list-of-all-colors-available-for-powershell
	#>
	[Alias("Get-AllColors","Get-Colors","Get-ColorsList")]
	#Requires -Version 3
	[CmdletBinding(DefaultParameterSetName = "Default")]
	Param(
		[Parameter(ParameterSetName = "ColorList")]
		[Alias('List','l','cl')]
		[Switch]$ColorList,
		
		[Parameter(ParameterSetName = "ColorList")]
		[Switch]$AddColorLabels,
		
		[Parameter(ParameterSetName = "ColorGrid")]
		[Alias('Grid','g','cg','ShowExamples','show','examples')]
		[Switch]$ColorGrid,
		
		#[Parameter(ParameterSetName = "ColorCompare")]
		#[Switch]$ConsoleColorComparison,
		
		[Alias('vt')]
		[Switch]$VtColors,
		
		[Alias('bw','bnw','black','white')]
		[Switch]$BlackAndWhite,
		
		[Alias('q')]
		[Switch]$Quiet,
		
		[Switch]$Alphabetic = $True
	)
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
	If ($ColorList) {
		# Print list to terminal
		
	} ElseIf ($ColorGrid) { # End If ($ColorList)
		# Arrange array to return
		
		$GridObj = @()
		
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
		
		#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
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
		#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		# End ElseIf $ColorGrid
	} ElseIf ($VtColors) { # End ElseIf ($ColorGrid)
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
	
	If ($VtColors) {
		
		<#
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
		} # End If/Else
		#>
		
	} ElseIf (!($Quiet)) { # End If ($VtColors)
		
		If ($ColorGrid -And !($VtColors)) {
			
			<#
			
			$GridObj = @()
			
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
			}
			
			#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
			
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
			
			# End If $ColorGrid
			#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
			#>
		} Else { # If ($ColorGrid -And !($VtColors))
			
			If ($VtColors -And ($Grid -Or $ColorGrid)) {
				$ResultsArray = @()
			}
			
			ForEach ($BgColor in $Colors) {
				
				If ($VtColors) {
					$VtBgColor = (ConvertTo-VtColorString -BackColor $BgColor -Raw -TerminalType 'default')
					If ($Grid) {
						$ColorExamples = ""
					}
					ForEach ($FgColor in $Colors) {
						$VtFgColor = (ConvertTo-VtColorString -ForeColor $FgColor -Raw -TerminalType 'default')
						$VtColorCode = $VtFgColor + ";" + $VtBgColor
						If ($Grid) {
							$ColorExamples = $ColorExamples + "$e[${VtColorCode}m$("$FgColor|")${e}[0m"
						} Else {
							Write-Host "$e[${VtColorCode}m$("$FgColor|")${e}[0m" -NoNewLine
						}
					}
					If ($Grid) {
						$ResultsArray += [PSCustomObject]@{ColorExamples = $ColorExamples; ColorName = " on $BgColor"; VtColorType = "default"; ColorError = ""}
					} Else {
						Write-Host " on $BgColor (default)"
					}
					
					$VtBgColor = (ConvertTo-VtColorString -BackColor $BgColor -Raw -TerminalType 'powershell.exe')
					If ($Grid) {
						$ColorExamples = ""
					}
					ForEach ($FgColor in $Colors) {
						$VtFgColor = (ConvertTo-VtColorString -ForeColor $FgColor -Raw -TerminalType 'powershell.exe')
						$VtColorCode = $VtFgColor + ";" + $VtBgColor
						If ($Grid) {
							$ColorExamples = $ColorExamples + "$e[${VtColorCode}m$("$FgColor|")${e}[0m"
						} Else {
							Write-Host "$e[${VtColorCode}m$("$FgColor|")${e}[0m" -NoNewLine
						}
					}
					If ($Grid) {
						If ($BgColor -eq 'DarkMagenta') {
							$ColorError = "(PoSh error: appears as blue powershell terminal background)"
							$ResultsArray += [PSCustomObject]@{ColorExamples = [String]$ColorExamples; ColorName = " on $BgColor"; VtColorType = "powershell.exe"; ColorError = $ColorError}
						} ElseIf ($BgColor -eq 'DarkYellow') {
							$ColorError = "(PoSh error: appears as a lighter gray than 'Gray', almost white but not quite)"
							$ResultsArray += [PSCustomObject]@{ColorExamples = [string]$ColorExamples; ColorName = " on $BgColor"; VtColorType = "powershell.exe"; ColorError = $ColorError}
						} Else {
							$ResultsArray += [PSCustomObject]@{ColorExamples = [string]$ColorExamples; ColorName = " on $BgColor"; VtColorType = "powershell.exe"; ColorError = ""}
						}
					} Else {
						Write-Host " on $BgColor (powershell.exe)"
					}
					
					$VtBgColor = (ConvertTo-VtColorString -BackColor $BgColor -Raw -TerminalType 'Code.exe')
					If ($Grid) {
						$ColorExamples = ""
					}
					ForEach ($FgColor in $Colors) {
						$VtFgColor = (ConvertTo-VtColorString -ForeColor $FgColor -Raw -TerminalType 'Code.exe')
						$VtColorCode = $VtFgColor + ";" + $VtBgColor
						If ($Grid) {
							$ColorExamples = $ColorExamples + "$e[${VtColorCode}m$("$FgColor|")${e}[0m"
						} Else {
							Write-Host "$e[${VtColorCode}m$("$FgColor|")${e}[0m" -NoNewLine
						}
					}
					If ($Grid) {
						If ($BgColor -eq 'Gray') {
							$ColorError = "(VsCode error: appears exact same as vscode white)"
							$ResultsArray += [PSCustomObject]@{ColorExamples = $ColorExamples; ColorName = " on $BgColor"; VtColorType = "Code.exe"; ColorError = $ColorError}
						} Else {
							$ResultsArray += [PSCustomObject]@{ColorExamples = $ColorExamples; ColorName = " on $BgColor"; VtColorType = "Code.exe"; ColorError = ""}
						}
					} Else {
						Write-Host " on $BgColor (Code.exe)"
					}
					
					# If $VtColors
				} Else {
					If ($BlackAndWhite) {
						Write-Host "Black|" -ForegroundColor 'Black' -BackgroundColor $BgColor -NoNewLine
						Write-Host "White|" -ForegroundColor 'White' -BackgroundColor $BgColor -NoNewLine
					} Else {
						ForEach ($FgColor in $Colors) {
							Write-Host "$FgColor|" -ForegroundColor $FgColor -BackgroundColor $BgColor -NoNewLine
						}
					}
					If (!($Grid)) {Write-Host " on $BgColor"} Else {Write-Host ""}
				}
			} # ForEach $BgColor
			
			<#
			If ($VtColors -And ($Grid -Or $ColorGrid)) {
				$ResultsArray = @()
			}
			#>
			
			If ($VtColors -And $Grid) {
				
				$ResultsArray | Format-Table -Property ColorExamples, ColorName, VtColorType, ColorError -AutoSize | Out-Host
				
			} ElseIf ($VtColors -And $ColorGrid) {
				
				$ResultsArray | Format-Table -Property ColorExamples | Out-Host
				
			}
			
			
			
			
			
		} # End If/then/else $ColorGrid
	} # End If not $Quiet
	If ($Quiet -And $BlackAndWhite) {
		$Colors = $Colors | Where-Object {$_ -match "Black|White"}
	}
	If ($Quiet) {Return $Colors}
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
	.PARAMETER TerminalType
	-TerminalType "default"
	-TerminalType "powershell.exe"
	-TerminalType "Code.exe"
	-TerminalType "VSCodium.exe"
	.PARAMETER Raw
	For certain colors that seem to produce incorrect output in certain terminals, show that color as measured, instead of correcting it.
	.NOTES
	.LINK
	https://stackoverflow.com/questions/20705102/how-to-colorise-powershell-output-of-format-table
	https://docs.microsoft.com/en-us/windows/console/console-virtual-terminal-sequences#text-formatting
	#>
	[CmdletBinding()]
	Param(
		[Parameter(Position = 0)]
		[String]$ForeColor,
		[Parameter(Position = 1)]
		[String]$BackColor,
		[Parameter(Mandatory = $False)]
		[ValidateSet("default","powershell.exe","powershell","posh","Code.exe","vscode","VSCodium.exe","vscodium",IgnoreCase = $True)]
		[String]$TerminalType,
		[switch]$Raw
	)
	#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	Function ConvertTo-DefaultVtColorString($ForeColor,$BackColor) {
		If ($ForeColor) {
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
					Write-Warning "Given ForeColor parameter could not be resolved. Reverting to default."
					#0 	Default 	Returns all attributes to the default state prior to modification
					#39 	Foreground Default 	Applies only the foreground portion of the defaults (see 0)
					#49 	Background Default 	Applies only the background portion of the defaults (see 0)
					$fcolor = "39"
				}
			} # switch
		}
		If ($BackColor) {
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
					Write-Warning "Given BackColor parameter could not be resolved. Reverting to default."
					#0 	Default 	Returns all attributes to the default state prior to modification
					#39 	Foreground Default 	Applies only the foreground portion of the defaults (see 0)
					#49 	Background Default 	Applies only the background portion of the defaults (see 0)
					$bcolor = "49"
				}
			} # switch
		}
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
	} # End ConvertTo-DefaultVtColorString
	#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	Function ConvertTo-PoshTerminalVtColorString($ForeColor,$BackColor) {
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
				Write-Warning "Given ForeColor parameter could not be resolved. Reverting to default."
				#0 	Default 	Returns all attributes to the default state prior to modification
				#39 	Foreground Default 	Applies only the foreground portion of the defaults (see 0)
				#49 	Background Default 	Applies only the background portion of the defaults (see 0)
				$fcolor = "39"
			}
		} # switch
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
				Write-Warning "Given BackColor parameter could not be resolved. Reverting to default."
				#0 	Default 	Returns all attributes to the default state prior to modification
				#39 	Foreground Default 	Applies only the foreground portion of the defaults (see 0)
				#49 	Background Default 	Applies only the background portion of the defaults (see 0)
				$bcolor = "49"
			}
		} # switch
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
	} # End ConvertTo-PoshTerminalVtColorString
	#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	Function ConvertTo-VscodeVtColorString($ForeColor,$BackColor) {
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
				Write-Warning "Given ForeColor parameter could not be resolved. Reverting to default."
				#0 	Default 	Returns all attributes to the default state prior to modification
				#39 	Foreground Default 	Applies only the foreground portion of the defaults (see 0)
				#49 	Background Default 	Applies only the background portion of the defaults (see 0)
				$fcolor = "39"
			}
		} # switch
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
				Write-Warning "Given BackColor parameter could not be resolved. Reverting to default."
				#0 	Default 	Returns all attributes to the default state prior to modification
				#39 	Foreground Default 	Applies only the foreground portion of the defaults (see 0)
				#49 	Background Default 	Applies only the background portion of the defaults (see 0)
				$bcolor = "49"
			}
		} # switch
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
	} # End ConvertTo-VscodeVtColorString
	#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	$SubFunctionParams = @{}
	If ($ForeColor) {
		$SubFunctionParams += @{ForeColor = $ForeColor}
	}
	If ($BackColor) {
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
			Write-Verbose "Default colors chosen. (Explicit)"
			$VTColorString = ConvertTo-DefaultVtColorString @SubFunctionParams
		} # 'default'
		'powershell.exe' {
			Write-Verbose "powershell.exe terminal colors chosen."
			$VTColorString = ConvertTo-PoshTerminalVtColorString @SubFunctionParams
		} # 'powershell.exe'
		'Code.exe' {
			Write-Verbose "vscode (Code.exe) console colors chosen."
			$VTColorString = ConvertTo-VscodeVtColorString @SubFunctionParams
		} # 'Code.exe'
		'VSCodium.exe' {
			Write-Verbose "VSCodium.exe console colors chosen."
			$VTColorString = ConvertTo-VscodeVtColorString @SubFunctionParams
		} # 'VSCodium.exe'
		Default {
			Write-Verbose "Default colors chosen. (Failover)"
			$VTColorString = ConvertTo-DefaultVtColorString @SubFunctionParams
		} # Default
	} # switch
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
#-----------------------------------------------------------------------------------------------------------------------
Function Get-DefaultMTMProjectPath {
	<#
	.SYNOPSIS
	Single-line summary.
	.DESCRIPTION
	Multiple paragraphs describing in more detail what the function is, what it does, how it works, inputs it expects, and outputs it creates.
	.NOTES
	Some extra info about this function, like it's origins, what module (if any) it's apart of, and where it's from.
	
	Maybe some original author credits as well.
	#>
	[Alias("Get-MTMPath")]
	#Requires -Version 3
	[CmdletBinding()]
	Param()
	#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	$CommonParameters = @{
		Verbose = [System.Management.Automation.ActionPreference]$VerbosePreference
		Debug = [System.Management.Automation.ActionPreference]$DebugPreference
	}
	#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	
	$DefualtProjectPath = "C:\Users\G\Documents\GitHub\MiniTaskMang-PoSh\Test Project"
	
	#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	Return $DefualtProjectPath
} # End of Get-DefaultMTMProjectPath function.
Set-Alias -Name 'Get-MTMPath' -Value 'Get-DefaultMTMProjectPath'
#-----------------------------------------------------------------------------------------------------------------------
#>



#-----------------------------------------------------------------------------------------------------------------------
Function Set-DefaultMTMProjectPath {
	<#
	.SYNOPSIS
	Single-line summary.
	.DESCRIPTION
	Multiple paragraphs describing in more detail what the function is, what it does, how it works, inputs it expects, and outputs it creates.
	.NOTES
	Some extra info about this function, like it's origins, what module (if any) it's apart of, and where it's from.
	
	Maybe some original author credits as well.
	#>
	[Alias("Set-MTMPath")]
	#Requires -Version 3
	[CmdletBinding()]
	Param(
		[Parameter(Mandatory = $True, Position = 0,
		           ValueFromPipeline = $True, 
		           ValueFromPipelineByPropertyName = $True,
		           HelpMessage = "Path to MiniTaskMang project folder")]
		[ValidateNotNullOrEmpty()]
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
	
	Write-Verbose "Get contents of $PathToModuleTemplate"
	
	Get-Content -Path $PathToModuleTemplate
	
	
	#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	
	
	
	#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	Return
} # End of Set-DefaultMTMProjectPath function.
Set-Alias -Name 'Set-MTMPath' -Value 'Set-DefaultMTMProjectPath'
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
	
	
	#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	Return
} # End of New-TaskTrackingInitiativeTEST function.
Set-Alias -Name 'New-ProjectInitTEST' -Value 'New-TaskTrackingInitiativeTEST'
#-----------------------------------------------------------------------------------------------------------------------


