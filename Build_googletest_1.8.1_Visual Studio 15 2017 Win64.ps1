. ".\Invoke-CmdScript.ps1"

# We expect PowerShell Version 5
if(-Not $PSVersionTable.PSVersion.Major -eq 5) {
	Write-Host "Expecting PowerShell Version 5"
	return
}

$AllProtocols = [System.Net.SecurityProtocolType]'Tls11,Tls12'
[System.Net.ServicePointManager]::SecurityProtocol = $AllProtocols

# Now download library
Invoke-WebRequest https://github.com/google/googletest/archive/release-1.8.1.zip  -OutFile C:\thirdparty\vs2017\x64\release-1.8.1.zip
	
# Extract file
$strFileName="$env:ProgramFiles\7-Zip\7z.exe"
If (Test-Path $strFileName){
	# Use 7-zip
	if (-not (test-path "$env:ProgramFiles\7-Zip\7z.exe")) {throw "$env:ProgramFiles\7-Zip\7z.exe needed"} 
	set-alias sz "$env:ProgramFiles\7-Zip\7z.exe"  
	sz x C:\thirdparty\vs2017\x64\release-1.8.1.zip -oC:\thirdparty\vs2017\x64
} Else {
	# use slow Windows stuff
	#Expand-Archive C:\thirdparty\vs2015\x64\release-1.8.1.zip -DestinationPath C:\thirdparty\vs2017\x64\Eigen_3.3.4
	Write-Host "Please install 7-zip"
	return
}

# Removed downloaded zip archive
Remove-Item C:\thirdparty\vs2017\x64\release-1.8.1.zip

Rename-Item -path "C:\thirdparty\vs2017\x64\googletest-release-1.8.1" -newName "C:\thirdparty\vs2017\x64\googletest-1.8.1"

C:
cd C:\thirdparty\vs2017\x64\googletest-1.8.1
cmake.exe `
-G "Visual Studio 15 2017 Win64" `
-HC:\thirdparty\vs2017\x64\googletest-1.8.1 `
-BC:\thirdparty\vs2017\x64\googletest-1.8.1\build `
-DBUILD_SHARED_LIBS="true"
cd C:\thirdparty\vs2017\x64\googletest-1.8.1\build
cmake --build . --config Debug
cmake --build . --config Release
cmake --build . --config RelWithDebInfo