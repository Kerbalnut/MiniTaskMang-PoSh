
<#
.SYNOPSIS
.DESCRIPTION
.NOTES
#>

$manifest = @{
	Path              = 'C:\Users\<username>\Documents\WindowsPowerShell\Modules\example\example.psd1'
	Author            = 'Grant James'
	CompanyName       = 'Example Corp.'
	Copyright         = '(c)2021 Grant James. All rights reserved.'
	Description       = 'Mini Task Manager module'
	GUID              = ''
	ModuleVersion     = '0.0'
	PowerShellVersion = '3.0'
	FunctionsToExport = 'New-CommentBlock', 'New-Function'
	ReleaseNotes      = ''
	RootModule        = 'example.psm1'
}

New-ModuleManifest @manifest
