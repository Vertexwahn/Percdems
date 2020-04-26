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

# Now download library
Invoke-WebRequest https://dl.bintray.com/boostorg/release/1.67.0/source/boost_1_67_0.zip -OutFile C:\thirdparty\vs2017\x64\boost_1_67_0.zip
	
# Check file hash
$value = Get-FileHash C:\thirdparty\vs2017\x64\boost_1_67_0.zip -Algorithm SHA256
	
if($value.Hash -ne "e1c55ebb00886c1a96528e4024be98a38b815115f62ecfe878fcf587ba715aad") {
	Write-Host "boost archive seems to be corrupted"
	return
}

# Extract file
$strFileName="$env:ProgramFiles\7-Zip\7z.exe"
If (Test-Path $strFileName){
	# Use 7-zip
	if (-not (test-path "$env:ProgramFiles\7-Zip\7z.exe")) {throw "$env:ProgramFiles\7-Zip\7z.exe needed"} 
	set-alias sz "$env:ProgramFiles\7-Zip\7z.exe"  
	sz x C:\thirdparty\vs2017\x64\boost_1_67_0.zip -oC:\thirdparty\vs2017\x64
} Else {
	Write-Host "Please install 7zip."
	return
}

# Removed downloaded zip archive
Remove-Item C:\thirdparty\vs2017\x64\boost_1_67_0.zip

# Setup VS2017 x64 environment
Invoke-CmdScript -script "C:\Program Files (x86)\Microsoft Visual Studio\2017\Enterprise\VC\Auxiliary\Build\vcvarsall.bat" -parameters amd64

# Build
cd C:\thirdparty\vs2017\x64\boost_1_67_0

$sw = [Diagnostics.Stopwatch]::StartNew()

Invoke-CmdScript -script "bootstrap.bat"

$cpuInfo = Get-CimInstance -ClassName 'Win32_Processor' `
    | Select-Object -Property 'DeviceID', 'Name', 'NumberOfCores', 'NumberOfLogicalProcessors';

Write-Host $cpuInfo.NumberOfLogicalProcessors

.\b2.exe --toolset=msvc-14.1 address-model=64 --build-type=complete stage -j $cpuInfo.NumberOfLogicalProcessors

$sw.Stop()

$ElapsedTime = $sw.Elapsed

write-host $([string]::Format("`rBuild Time (hh:mm:ss): {0:d2}:{1:d2}:{2:d2}",
                              $ElapsedTime.hours, 
                              $ElapsedTime.minutes, 
                              $ElapsedTime.seconds)) -nonewline