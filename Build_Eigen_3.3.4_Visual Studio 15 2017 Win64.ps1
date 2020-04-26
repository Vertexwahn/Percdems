. ".\Invoke-CmdScript.ps1"

# We expect PowerShell Version 5
if(-Not $PSVersionTable.PSVersion.Major -eq 5) {
	Write-Host "Expecting PowerShell Version 5"
	return
}

# Now download library
Invoke-WebRequest http://bitbucket.org/eigen/eigen/get/3.3.4.zip -OutFile C:\thirdparty\vs2017\x64\Eigen_3_3_4.zip
	
# Extract file
$strFileName="$env:ProgramFiles\7-Zip\7z.exe"
If (Test-Path $strFileName){
	# Use 7-zip
	if (-not (test-path "$env:ProgramFiles\7-Zip\7z.exe")) {throw "$env:ProgramFiles\7-Zip\7z.exe needed"} 
	set-alias sz "$env:ProgramFiles\7-Zip\7z.exe"  
	sz x C:\thirdparty\vs2017\x64\Eigen_3_3_4.zip -oC:\thirdparty\vs2017\x64
} Else {
	# use slow Windows stuff
	Expand-Archive C:\thirdparty\vs2017\x64\Eigen_3_3_4.zip -DestinationPath C:\thirdparty\vs2017\x64\Eigen_3.3.4
}

# Removed downloaded zip archive
Remove-Item C:\thirdparty\vs2017\x64\Eigen_3_3_4.zip

Rename-Item -path "C:\thirdparty\vs2017\x64\eigen-eigen-5a0156e40feb" -newName "C:\thirdparty\vs2017\x64\Eigen_3.3.4"