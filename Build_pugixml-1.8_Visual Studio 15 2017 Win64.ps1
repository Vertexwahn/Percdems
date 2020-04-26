. ".\Invoke-CmdScript.ps1" # Need for calling commands

# We expect PowerShell Version 5
if(-Not $PSVersionTable.PSVersion.Major -eq 5) {
	Write-Host "Expecting PowerShell Version 5"
	return
}

# Create target dir folder if it does not exist
$TARGETDIR = "C:\thirdparty\vs2017\x64"
if( -Not (Test-Path -Path $TARGETDIR ) ) {
    New-Item -ItemType directory -Path $TARGETDIR
}

# Download library
Invoke-WebRequest http://github.com/zeux/pugixml/releases/download/v1.8/pugixml-1.8.zip -OutFile C:\thirdparty\vs2017\x64\pugixml-1.8.zip

# Extract file
$strFileName="$env:ProgramFiles\7-Zip\7z.exe"
If (Test-Path $strFileName){
	# Use 7-zip
	if (-not (test-path "$env:ProgramFiles\7-Zip\7z.exe")) {throw "$env:ProgramFiles\7-Zip\7z.exe needed"} 
	set-alias sz "$env:ProgramFiles\7-Zip\7z.exe"  
	sz x C:\thirdparty\vs2017\x64\pugixml-1.8.zip -oC:\thirdparty\vs2017\x64
} Else {
	# use slow Windows stuff
	Expand-Archive C:\thirdparty\vs2017\x64\pugixml-1.8.zip -DestinationPath C:\thirdparty\vs2017\x64\pugixml-1.8
}

# Removed downloaded zip archive
Remove-Item C:\thirdparty\vs2017\x64\pugixml-1.8.zip

# Setup VS2017 x64 environment
Invoke-CmdScript -script "C:\Program Files (x86)\Microsoft Visual Studio\2017\Enterprise\VC\Auxiliary\Build\vcvarsall.bat" -parameters amd64

cmake -G"Visual Studio 14 2015 Win64" -HC:\thirdparty\vs2017\x64\pugixml-1.8 -BC:\thirdparty\vs2017\x64\pugixml-1.8\build
C:
cd C:\thirdparty\vs2017\x64\pugixml-1.8\build
cmake --build . --config Release
cmake --build . --config Debug