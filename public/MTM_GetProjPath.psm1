
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
	[CmdletBinding()]
	Param()
	Return "C:\Users\G\Documents\GitHub\MiniTaskMang-PoSh\Test Project"
	#Return $DefaultPath
}
Set-Alias -Name 'Get-MTMPath' -Value 'Get-DefaultMTMProjectPath'

