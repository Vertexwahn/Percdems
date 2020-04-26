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
Invoke-WebRequest https://github.com/embree/embree/archive/v2.17.0.zip -OutFile C:\thirdparty\vs2017\x64\v2.17.0.zip
	
# Extract file
$strFileName="$env:ProgramFiles\7-Zip\7z.exe"
If (Test-Path $strFileName){
	# Use 7-zip
	if (-not (test-path "$env:ProgramFiles\7-Zip\7z.exe")) {throw "$env:ProgramFiles\7-Zip\7z.exe needed"} 
	set-alias sz "$env:ProgramFiles\7-Zip\7z.exe"  
	sz x C:\thirdparty\vs2017\x64\v2.17.0.zip -oC:\thirdparty\vs2017\x64
} Else {
	Write-Host "Please install 7zip."
	return
}

# Removed downloaded zip archive
Remove-Item C:\thirdparty\vs2017\x64\v2.17.0.zip

Copy-Item Embree\FindTBB.cmake -Destination C:\thirdparty\vs2017\x64\embree-2.17.0\common\cmake\FindTBB.cmake

# Build it - requires a prebuild version of TBB
C:

$sw = [Diagnostics.Stopwatch]::StartNew()

# Setup vs2017 x64 environment
Invoke-CmdScript -script "C:\Program Files (x86)\Microsoft Visual Studio\2017\Enterprise\VC\Auxiliary\Build\vcvarsall.bat" -parameters amd64

cmake.exe `
-G "Visual Studio 15 2017 Win64" `
-HC:\thirdparty\vs2017\x64\embree-2.17.0 `
-BC:\thirdparty\vs2017\x64\embree-2.17.0\build `
-DEMBREE_ISPC_SUPPORT="false" `
-DEMBREE_TBB_ROOT=C:\thirdparty\vs2017\x64\tbb-2018_U1

cd C:\thirdparty\vs2017\x64\embree-2.17.0\build
cmake --build . --config Debug
cmake --build . --config Release
cmake --build . --config RelWithDebInfo

$sw.Stop()

$ElapsedTime = $sw.Elapsed

write-host $([string]::Format("`rBuild Time (hh:mm:ss): {0:d2}:{1:d2}:{2:d2}",
                              $ElapsedTime.hours, 
                              $ElapsedTime.minutes, 
                              $ElapsedTime.seconds)) -nonewline