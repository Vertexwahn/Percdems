. ".\Invoke-CmdScript.ps1"

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
Invoke-WebRequest http://releases.llvm.org/4.0.1/llvm-4.0.1.src.tar.xz -OutFile C:\thirdparty\vs2017\x64\llvm-4.0.1.src.tar.xz

# Extract file
$strFileName="$env:ProgramFiles\7-Zip\7z.exe"
If (Test-Path $strFileName){
	# Use 7-zip
	if (-not (test-path "$env:ProgramFiles\7-Zip\7z.exe")) {throw "$env:ProgramFiles\7-Zip\7z.exe needed"} 
	set-alias sz "$env:ProgramFiles\7-Zip\7z.exe"  
	sz x C:\thirdparty\vs2017\x64\llvm-4.0.1.src.tar.xz -oC:\thirdparty\vs2017\x64
} Else {
	Write-Host "Please install 7zip."
	return
}

# Removed downloaded archive
Remove-Item C:\thirdparty\vs2017\x64\llvm-4.0.1.src.tar.xz

# Extract file
$strFileName="$env:ProgramFiles\7-Zip\7z.exe"
If (Test-Path $strFileName){
	# Use 7-zip
	if (-not (test-path "$env:ProgramFiles\7-Zip\7z.exe")) {throw "$env:ProgramFiles\7-Zip\7z.exe needed"} 
	set-alias sz "$env:ProgramFiles\7-Zip\7z.exe"  
	sz x C:\thirdparty\vs2017\x64\llvm-4.0.1.src.tar -oC:\thirdparty\vs2017\x64
} Else {
	Write-Host "Please install 7zip."
	return
}

Remove-Item  C:\thirdparty\vs2017\x64\llvm-4.0.1.src.tar

Rename-Item -path "C:\thirdparty\vs2017\x64\llvm-4.0.1.src" -newName "C:\thirdparty\vs2017\x64\llvm-4.0.1"

# Setup VS2017 x64 environment
Invoke-CmdScript -script "C:\Program Files (x86)\Microsoft Visual Studio\2017\Enterprise\VC\Auxiliary\Build\vcvarsall.bat" -parameters amd64

cmake -G"Visual Studio 15 2017 Win64" -HC:\thirdparty\vs2017\x64\llvm-4.0.1 -BC:\thirdparty\vs2017\x64\llvm-4.0.1
cd C:\thirdparty\vs2017\x64\llvm-4.0.1
cmake --build .