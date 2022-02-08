
Function Get-DefaultMTMProjectPath {
	[Alias("Get-MTMPath")]
	[CmdletBinding()]
	Param()
	Return "C:\Users\G\Documents\GitHub\MiniTaskMang-PoSh\Test Project"
}
Set-Alias -Name 'Get-MTMPath' -Value 'Get-DefaultMTMProjectPath'

