
#-----------------------------------------------------------------------------------------------------------------------
Function Get-FolderSize {
	<#
	.SYNOPSIS
	Returns a human-readable file/folder size for a given path.
	.DESCRIPTION
	.NOTES
	.PARAMETER Path
	.PARAMETER Units
	#>
	[Alias("Get-FileSize")]
	[CmdletBinding()]
	Param(
		[Parameter(Mandatory = $True, Position = 0, ValueFromPipeline = $True, ValueFromPipelineByPropertyName = $True)]
		$Path,
		
		[Parameter(Mandatory = $False, Position = 1, ValueFromPipelineByPropertyName = $True)]]
		[ValidateSet("KB","MB","GB")]
		$Units
	)
	
	
	
	
}
#-----------------------------------------------------------------------------------------------------------------------


