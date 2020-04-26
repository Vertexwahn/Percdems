. ".\Invoke-CmdScript.ps1"

# We expect PowerShell Version 5
if(-Not $PSVersionTable.PSVersion.Major -eq 5) {
	Write-Host "Expecting PowerShell Version 5"
	return
}

# Now download library
git clone https://github.com/aekul/aether C:\thirdparty\vs2017\x64\aether\aether