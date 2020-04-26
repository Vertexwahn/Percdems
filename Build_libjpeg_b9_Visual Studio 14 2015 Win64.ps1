# see here: http://www.ridgesolutions.ie/index.php/2014/10/28/compiling-building-libjpeg-for-windows/

. ".\Invoke-CmdScript.ps1"

# We expect PowerShell Version 5
if(-Not $PSVersionTable.PSVersion.Major -eq 5) {
	Write-Host "Expecting PowerShell Version 5"
	return
}

# Now download boost 1.64.0
Invoke-WebRequest http://ijg.org/files/jpegsr9b.zip -OutFile C:\thirdparty\vs2015\x64\jpegsr9b.zip
	
# Extract file
$strFileName="$env:ProgramFiles\7-Zip\7z.exe"
If (Test-Path $strFileName){
	# Use 7-zip
	if (-not (test-path "$env:ProgramFiles\7-Zip\7z.exe")) {throw "$env:ProgramFiles\7-Zip\7z.exe needed"} 
	set-alias sz "$env:ProgramFiles\7-Zip\7z.exe"  
	sz x C:\thirdparty\vs2015\x64\jpegsr9b.zip -oC:\thirdparty\vs2015\x64
} Else {
	# use slow Windows stuff
	Write-Host "Please install 7zip."
}

# Removed downloaded zip archive
Remove-Item C:\thirdparty\vs2015\x64\jpegsr9b.zip

C:

# Setup VS2017 x64 environment
Invoke-CmdScript -script "C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\vcvarsall.bat" -parameters amd64

[Environment]::SetEnvironmentVariable("INCLUDE", "%INCLUDE%;c:\Program Files (x86)\Microsoft SDKs\Windows\v7.1A\Include", "User")
#set INCLUDE=%INCLUDE%;c:\Program Files (x86)\Microsoft SDKs\Windows\v7.1A\Include

cd C:\thirdparty\vs2015\x64\jpeg-9b

cmd.exe copy jconfig.vc jconfig.h
cmd.exe copy makelib.ds jpeg.mak
cmd.exe copy makeapps.ds apps.mak
 
nmake -f makefile.vc setup-v10

set-alias DevenvPS "C:\Program Files (x86)\Microsoft Visual Studio 14.0\Common7\IDE\devenv.com"
DevenvPS jpeg.sln /Upgrade

DevenvPS jpeg.sln /build "Release|x64" /project jpeg