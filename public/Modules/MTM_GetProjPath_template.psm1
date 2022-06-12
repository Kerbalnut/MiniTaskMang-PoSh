
#-----------------------------------------------------------------------------------------------------------------------
Function Get-DefaultMTMProjectPath {
	<#
	.SYNOPSIS
	Returns the path to the currently-selected MTM MiniTaskMang project.
	.DESCRIPTION
	Automatically-generated function for use with the MiniTaskMang (MTM) module. Use Set-DefaultMTMProjectPath to automatically configure this function.
	.NOTES
	$Notes
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
	
	$DefualtProjectPath = $InsertPath
	
	#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	Return $DefualtProjectPath
} # End of Get-DefaultMTMProjectPath function.
Set-Alias -Name 'Get-MTMPath' -Value 'Get-DefaultMTMProjectPath'
#-----------------------------------------------------------------------------------------------------------------------


