. ".\Invoke-CmdScript.ps1"

# We expect PowerShell Version 5
if(-Not $PSVersionTable.PSVersion.Major -eq 5) {
	Write-Host "Expecting PowerShell Version 5"
	return
}

# Now download library
Invoke-WebRequest http://download.librdf.org/source/raptor2-2.0.15.tar.gz -OutFile C:\thirdparty\vs2017\x64\raptor2-2.0.15.tar.gz
	
# Extract file
$strFileName="$env:ProgramFiles\7-Zip\7z.exe"
If (Test-Path $strFileName){
	# Use 7-zip
	if (-not (test-path "$env:ProgramFiles\7-Zip\7z.exe")) {throw "$env:ProgramFiles\7-Zip\7z.exe needed"} 
	set-alias sz "$env:ProgramFiles\7-Zip\7z.exe"  
	sz x C:\thirdparty\vs2017\x64\raptor2-2.0.15.tar.gz -oC:\thirdparty\vs2017\x64
} Else {
	# use slow Windows stuff
	Expand-Archive C:\thirdparty\vs2017\x64\raptor2-2.0.15.tar.gz -DestinationPath C:\thirdparty\vs2017\x64\raptor2-2.0.15.tar
}

If (Test-Path $strFileName){
	# Use 7-zip
	if (-not (test-path "$env:ProgramFiles\7-Zip\7z.exe")) {throw "$env:ProgramFiles\7-Zip\7z.exe needed"} 
	set-alias sz "$env:ProgramFiles\7-Zip\7z.exe"  
	sz x C:\thirdparty\vs2017\x64\raptor2-2.0.15.tar -oC:\thirdparty\vs2017\x64
} Else {
	# use slow Windows stuff
	Expand-Archive C:\thirdparty\vs2017\x64\raptor2-2.0.15.tar -DestinationPath C:\thirdparty\vs2017\x64\raptor2-2.0.15
}

# Removed downloaded zip archive
Remove-Item C:\thirdparty\vs2017\x64\raptor2-2.0.15.tar.gz
Remove-Item C:\thirdparty\vs2017\x64\raptor2-2.0.15.tar

# Patch raptor
Copy-Item RaptorPatch\CMakeLists.txt -Destination C:\thirdparty\vs2017\x64\raptor2-2.0.15\CMakeLists.txt
Copy-Item RaptorPatch\src\CMakeLists.txt -Destination C:\thirdparty\vs2017\x64\raptor2-2.0.15\src\CMakeLists.txt

# Setup VS2017 x64 environment
Invoke-CmdScript -script "C:\Program Files (x86)\Microsoft Visual Studio\2017\Enterprise\VC\Auxiliary\Build\vcvarsall.bat" -parameters amd64

cmake -G"Visual Studio 15 2017 Win64" `
-DLIBXML2_INCLUDE_DIR=C:\dev\vcpkg\installed\x64-windows\include `
-DLIBXML2_LIBRARIRES=C:\dev\vcpkg\installed\x64-windows\lib\libxml2.lib `
-DLIBXSLT_INCLUDE_DIR=C:\dev\vcpkg\installed\x64-windows\include `
-DLIBXSLT_LIBRARIRES=C:\dev\vcpkg\installed/x64-windows\lib\libxlst.lib `
-DLIBXSLT_EXSLT_LIBRARIRY=C:\dev\vcpkg\installed\x64-windows\lib\libexlst.lib `
-HC:\thirdparty\vs2017\x64\raptor2-2.0.15 `
-BC:\thirdparty\vs2017\x64\raptor2-2.0.15\build 
C:
cd C:\thirdparty\vs2017\x64\raptor2-2.0.15

cmake --build . --config Debug --target raptor2
cmake --build . --config RelWithDebInfo --target raptor2
cmake --build . --config Release --target raptor2