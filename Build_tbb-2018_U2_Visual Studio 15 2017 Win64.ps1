. ".\Invoke-CmdScript.ps1"

# We expect PowerShell Version 5
if(-Not $PSVersionTable.PSVersion.Major -eq 5) {
	Write-Host "Expecting PowerShell Version 5"
	return
}

# Create target dir folder if it does not exist
$TARGETDIR = "C:\thirdparty\vs2017\x64"
if( -Not (Test-Path -Path $TARGETDIR ) )
{
    New-Item -ItemType directory -Path $TARGETDIR
}

# download source code
Invoke-WebRequest https://github.com/01org/tbb/archive/2018_U2.zip -OutFile C:\thirdparty\vs2017\x64\2018_U2.zip
	
# Extract file
$strFileName="$env:ProgramFiles\7-Zip\7z.exe"
If (Test-Path $strFileName){
	# Use 7-zip
	if (-not (test-path "$env:ProgramFiles\7-Zip\7z.exe")) {throw "$env:ProgramFiles\7-Zip\7z.exe needed"} 
	set-alias sz "$env:ProgramFiles\7-Zip\7z.exe"  
	sz x C:\thirdparty\vs2017\x64\2018_U2.zip -oC:\thirdparty\vs2017\x64
} Else {
	# use slow Windows stuff
	Write-Host "Please install 7zip."
}

# Removed downloaded zip archive
Remove-Item C:\thirdparty\vs2017\x64\2018_U2.zip

# Build it
C:

$sw = [Diagnostics.Stopwatch]::StartNew()

# Setup vs2017 x64 environment
Invoke-CmdScript -script "C:\Program Files (x86)\Microsoft Visual Studio\2017\Enterprise\VC\Auxiliary\Build\vcvarsall.bat" -parameters amd64

cd C:\thirdparty\vs2017\x64\tbb-2018_U2\build\vs2013

set-alias DevenvPS "C:\Program Files (x86)\Microsoft Visual Studio\2017\Enterprise\Common7\IDE\devenv.com"

DevenvPS makefile.sln /Upgrade

DevenvPS makefile.sln /build "Debug|x64" /project tbb
DevenvPS makefile.sln /build "Debug|x64" /project tbbmalloc
DevenvPS makefile.sln /build "Debug|x64" /project tbbmalloc_proxy
DevenvPS makefile.sln /build "Release|x64" /project tbb
DevenvPS makefile.sln /build "Release|x64" /project tbbmalloc
DevenvPS makefile.sln /build "Release|x64" /project tbbmalloc_proxy
DevenvPS makefile.sln /build "Debug|Win32" /project tbb
DevenvPS makefile.sln /build "Debug|Win32" /project tbbmalloc
DevenvPS makefile.sln /build "Debug|Win32" /project tbbmalloc_proxy
DevenvPS makefile.sln /build "Release|Win32" /project tbb
DevenvPS makefile.sln /build "Release|Win32" /project tbbmalloc
DevenvPS makefile.sln /build "Release|Win32" /project tbbmalloc_proxy

$sw.Stop()

$ElapsedTime = $sw.Elapsed

write-host $([string]::Format("`rBuild Time (hh:mm:ss): {0:d2}:{1:d2}:{2:d2}",
                              $ElapsedTime.hours, 
                              $ElapsedTime.minutes, 
                              $ElapsedTime.seconds)) -nonewline

New-Item -Path "..\..\bin\ia32\vc15" -ItemType directory
New-Item -Path "..\..\lib\ia32\vc15" -ItemType directory

New-Item -Path "..\..\bin\intel64\vc15" -ItemType directory
New-Item -Path "..\..\lib\intel64\vc15" -ItemType directory

cd ../../

Copy-Item build\vs2013\Win32\Debug\tbbmalloc_debug.dll -Destination C:\thirdparty\vs2017\x64\tbb-2018_U2\bin\ia32\vc15\tbbmalloc_debug.dll
Copy-Item build\vs2013\Win32\Debug\tbbmalloc_debug.exp -Destination C:\thirdparty\vs2017\x64\tbb-2018_U2\lib\ia32\vc15\tbbmalloc_debug.exp
Copy-Item build\vs2013\Win32\Debug\tbbmalloc_debug.lib -Destination C:\thirdparty\vs2017\x64\tbb-2018_U2\lib\ia32\vc15\tbbmalloc_debug.lib
Copy-Item build\vs2013\Win32\Debug\tbbmalloc_debug.map -Destination C:\thirdparty\vs2017\x64\tbb-2018_U2\lib\ia32\vc15\tbbmalloc_debug.map
Copy-Item build\vs2013\Win32\Debug\tbbmalloc_debug.pdb -Destination C:\thirdparty\vs2017\x64\tbb-2018_U2\lib\ia32\vc15\tbbmalloc_debug.pdb
Copy-Item build\vs2013\Win32\Debug\tbbmalloc_proxy_debug.dll -Destination C:\thirdparty\vs2017\x64\tbb-2018_U2\bin\ia32\vc15\tbbmalloc_proxy_debug.dll
Copy-Item build\vs2013\Win32\Debug\tbbmalloc_proxy_debug.exp -Destination C:\thirdparty\vs2017\x64\tbb-2018_U2\lib\ia32\vc15\tbbmalloc_proxy_debug.exp
Copy-Item build\vs2013\Win32\Debug\tbbmalloc_proxy_debug.lib -Destination C:\thirdparty\vs2017\x64\tbb-2018_U2\lib\ia32\vc15\tbbmalloc_proxy_debug.lib
Copy-Item build\vs2013\Win32\Debug\tbbmalloc_proxy_debug.map -Destination C:\thirdparty\vs2017\x64\tbb-2018_U2\lib\ia32\vc15\tbbmalloc_proxy_debug.map
Copy-Item build\vs2013\Win32\Debug\tbbmalloc_proxy_debug.pdb -Destination C:\thirdparty\vs2017\x64\tbb-2018_U2\lib\ia32\vc15\tbbmalloc_proxy_debug.pdb
Copy-Item build\vs2013\Win32\Debug\tbb_debug.dll -Destination C:\thirdparty\vs2017\x64\tbb-2018_U2\bin\ia32\vc15\tbb_debug.dll
Copy-Item build\vs2013\Win32\Debug\tbb_debug.exp -Destination C:\thirdparty\vs2017\x64\tbb-2018_U2\lib\ia32\vc15\tbb_debug.exp
Copy-Item build\vs2013\Win32\Debug\tbb_debug.lib -Destination C:\thirdparty\vs2017\x64\tbb-2018_U2\lib\ia32\vc15\tbb_debug.lib
Copy-Item build\vs2013\Win32\Debug\tbb_debug.map -Destination C:\thirdparty\vs2017\x64\tbb-2018_U2\lib\ia32\vc15\tbb_debug.map
Copy-Item build\vs2013\Win32\Debug\tbb_debug.pdb -Destination C:\thirdparty\vs2017\x64\tbb-2018_U2\lib\ia32\vc15\tbb_debug.pdb

Copy-Item build\vs2013\Win32\Release\tbb.dll -Destination C:\thirdparty\vs2017\x64\tbb-2018_U2\bin\ia32\vc15\tbb.dll
Copy-Item build\vs2013\Win32\Release\tbb.exp -Destination C:\thirdparty\vs2017\x64\tbb-2018_U2\lib\ia32\vc15\tbb.exp
Copy-Item build\vs2013\Win32\Release\tbb.iobj -Destination C:\thirdparty\vs2017\x64\tbb-2018_U2\lib\ia32\vc15\tbb.iobj
Copy-Item build\vs2013\Win32\Release\tbb.ipdb -Destination C:\thirdparty\vs2017\x64\tbb-2018_U2\lib\ia32\vc15\tbb.ipdb
Copy-Item build\vs2013\Win32\Release\tbb.lib -Destination C:\thirdparty\vs2017\x64\tbb-2018_U2\lib\ia32\vc15\tbb.lib
Copy-Item build\vs2013\Win32\Release\tbb.map -Destination C:\thirdparty\vs2017\x64\tbb-2018_U2\lib\ia32\vc15\tbb.map
Copy-Item build\vs2013\Win32\Release\tbb.pdb -Destination C:\thirdparty\vs2017\x64\tbb-2018_U2\lib\ia32\vc15\tbb.pdb
Copy-Item build\vs2013\Win32\Release\tbbmalloc.dll -Destination C:\thirdparty\vs2017\x64\tbb-2018_U2\bin\ia32\vc15\tbbmalloc.dll
Copy-Item build\vs2013\Win32\Release\tbbmalloc.exp -Destination C:\thirdparty\vs2017\x64\tbb-2018_U2\lib\ia32\vc15\tbbmalloc.exp
Copy-Item build\vs2013\Win32\Release\tbbmalloc.iobj -Destination C:\thirdparty\vs2017\x64\tbb-2018_U2\lib\ia32\vc15\tbbmalloc.iobj
Copy-Item build\vs2013\Win32\Release\tbbmalloc.ipdb -Destination C:\thirdparty\vs2017\x64\tbb-2018_U2\lib\ia32\vc15\tbbmalloc.ipdb
Copy-Item build\vs2013\Win32\Release\tbbmalloc.lib -Destination C:\thirdparty\vs2017\x64\tbb-2018_U2\lib\ia32\vc15\tbbmalloc.lib
Copy-Item build\vs2013\Win32\Release\tbbmalloc.map -Destination C:\thirdparty\vs2017\x64\tbb-2018_U2\lib\ia32\vc15\tbbmalloc.map
Copy-Item build\vs2013\Win32\Release\tbbmalloc.pdb -Destination C:\thirdparty\vs2017\x64\tbb-2018_U2\lib\ia32\vc15\tbbmalloc.pdb
Copy-Item build\vs2013\Win32\Release\tbbmalloc_proxy.dll -Destination C:\thirdparty\vs2017\x64\tbb-2018_U2\bin\ia32\vc15\tbbmalloc_proxy.dll
Copy-Item build\vs2013\Win32\Release\tbbmalloc_proxy.exp -Destination C:\thirdparty\vs2017\x64\tbb-2018_U2\lib\ia32\vc15\tbbmalloc_proxy.exp
Copy-Item build\vs2013\Win32\Release\tbbmalloc_proxy.iobj -Destination C:\thirdparty\vs2017\x64\tbb-2018_U2\lib\ia32\vc15\tbbmalloc_proxy.iobj
Copy-Item build\vs2013\Win32\Release\tbbmalloc_proxy.ipdb -Destination C:\thirdparty\vs2017\x64\tbb-2018_U2\lib\ia32\vc15\tbbmalloc_proxy.ipdb
Copy-Item build\vs2013\Win32\Release\tbbmalloc_proxy.lib -Destination C:\thirdparty\vs2017\x64\tbb-2018_U2\lib\ia32\vc15\tbbmalloc_proxy.lib
Copy-Item build\vs2013\Win32\Release\tbbmalloc_proxy.map -Destination C:\thirdparty\vs2017\x64\tbb-2018_U2\lib\ia32\vc15\tbbmalloc_proxy.map
Copy-Item build\vs2013\Win32\Release\tbbmalloc_proxy.pdb -Destination C:\thirdparty\vs2017\x64\tbb-2018_U2\lib\ia32\vc15\tbbmalloc_proxy.pdb




Copy-Item build\vs2013\x64\Debug\tbbmalloc_debug.dll -Destination C:\thirdparty\vs2017\x64\tbb-2018_U2\bin\intel64\vc15\tbbmalloc_debug.dll
Copy-Item build\vs2013\x64\Debug\tbbmalloc_debug.exp -Destination C:\thirdparty\vs2017\x64\tbb-2018_U2\lib\intel64\vc15\tbbmalloc_debug.exp
Copy-Item build\vs2013\x64\Debug\tbbmalloc_debug.lib -Destination C:\thirdparty\vs2017\x64\tbb-2018_U2\lib\intel64\vc15\tbbmalloc_debug.lib
Copy-Item build\vs2013\x64\Debug\tbbmalloc_debug.map -Destination C:\thirdparty\vs2017\x64\tbb-2018_U2\lib\intel64\vc15\tbbmalloc_debug.map
Copy-Item build\vs2013\x64\Debug\tbbmalloc_debug.pdb -Destination C:\thirdparty\vs2017\x64\tbb-2018_U2\lib\intel64\vc15\tbbmalloc_debug.pdb
Copy-Item build\vs2013\x64\Debug\tbbmalloc_proxy_debug.dll -Destination C:\thirdparty\vs2017\x64\tbb-2018_U2\bin\intel64\vc15\tbbmalloc_proxy_debug.dll
Copy-Item build\vs2013\x64\Debug\tbbmalloc_proxy_debug.exp -Destination C:\thirdparty\vs2017\x64\tbb-2018_U2\lib\intel64\vc15\tbbmalloc_proxy_debug.exp
Copy-Item build\vs2013\x64\Debug\tbbmalloc_proxy_debug.lib -Destination C:\thirdparty\vs2017\x64\tbb-2018_U2\lib\intel64\vc15\tbbmalloc_proxy_debug.lib
Copy-Item build\vs2013\x64\Debug\tbbmalloc_proxy_debug.map -Destination C:\thirdparty\vs2017\x64\tbb-2018_U2\lib\intel64\vc15\tbbmalloc_proxy_debug.map
Copy-Item build\vs2013\x64\Debug\tbbmalloc_proxy_debug.pdb -Destination C:\thirdparty\vs2017\x64\tbb-2018_U2\lib\intel64\vc15\tbbmalloc_proxy_debug.pdb
Copy-Item build\vs2013\x64\Debug\tbb_debug.dll -Destination C:\thirdparty\vs2017\x64\tbb-2018_U2\bin\intel64\vc15\tbb_debug.dll
Copy-Item build\vs2013\x64\Debug\tbb_debug.exp -Destination C:\thirdparty\vs2017\x64\tbb-2018_U2\lib\intel64\vc15\tbb_debug.exp
Copy-Item build\vs2013\x64\Debug\tbb_debug.lib -Destination C:\thirdparty\vs2017\x64\tbb-2018_U2\lib\intel64\vc15\tbb_debug.lib
Copy-Item build\vs2013\x64\Debug\tbb_debug.map -Destination C:\thirdparty\vs2017\x64\tbb-2018_U2\lib\intel64\vc15\tbb_debug.map
Copy-Item build\vs2013\x64\Debug\tbb_debug.pdb -Destination C:\thirdparty\vs2017\x64\tbb-2018_U2\lib\intel64\vc15\tbb_debug.pdb

Copy-Item build\vs2013\x64\Release\tbb.dll -Destination C:\thirdparty\vs2017\x64\tbb-2018_U2\bin\intel64\vc15\tbb.dll
Copy-Item build\vs2013\x64\Release\tbb.exp -Destination C:\thirdparty\vs2017\x64\tbb-2018_U2\lib\intel64\vc15\tbb.exp
Copy-Item build\vs2013\x64\Release\tbb.iobj -Destination C:\thirdparty\vs2017\x64\tbb-2018_U2\lib\intel64\vc15\tbb.iobj
Copy-Item build\vs2013\x64\Release\tbb.ipdb -Destination C:\thirdparty\vs2017\x64\tbb-2018_U2\lib\intel64\vc15\tbb.ipdb
Copy-Item build\vs2013\x64\Release\tbb.lib -Destination C:\thirdparty\vs2017\x64\tbb-2018_U2\lib\intel64\vc15\tbb.lib
Copy-Item build\vs2013\x64\Release\tbb.map -Destination C:\thirdparty\vs2017\x64\tbb-2018_U2\lib\intel64\vc15\tbb.map
Copy-Item build\vs2013\x64\Release\tbb.pdb -Destination C:\thirdparty\vs2017\x64\tbb-2018_U2\lib\intel64\vc15\tbb.pdb
Copy-Item build\vs2013\x64\Release\tbbmalloc.dll -Destination C:\thirdparty\vs2017\x64\tbb-2018_U2\bin\intel64\vc15\tbbmalloc.dll
Copy-Item build\vs2013\x64\Release\tbbmalloc.exp -Destination C:\thirdparty\vs2017\x64\tbb-2018_U2\lib\intel64\vc15\tbbmalloc.exp
Copy-Item build\vs2013\x64\Release\tbbmalloc.iobj -Destination C:\thirdparty\vs2017\x64\tbb-2018_U2\lib\intel64\vc15\tbbmalloc.iobj
Copy-Item build\vs2013\x64\Release\tbbmalloc.ipdb -Destination C:\thirdparty\vs2017\x64\tbb-2018_U2\lib\intel64\vc15\tbbmalloc.ipdb
Copy-Item build\vs2013\x64\Release\tbbmalloc.lib -Destination C:\thirdparty\vs2017\x64\tbb-2018_U2\lib\intel64\vc15\tbbmalloc.lib
Copy-Item build\vs2013\x64\Release\tbbmalloc.map -Destination C:\thirdparty\vs2017\x64\tbb-2018_U2\lib\intel64\vc15\tbbmalloc.map
Copy-Item build\vs2013\x64\Release\tbbmalloc.pdb -Destination C:\thirdparty\vs2017\x64\tbb-2018_U2\lib\intel64\vc15\tbbmalloc.pdb
Copy-Item build\vs2013\x64\Release\tbbmalloc_proxy.dll -Destination C:\thirdparty\vs2017\x64\tbb-2018_U2\bin\intel64\vc15\tbbmalloc_proxy.dll
Copy-Item build\vs2013\x64\Release\tbbmalloc_proxy.exp -Destination C:\thirdparty\vs2017\x64\tbb-2018_U2\lib\intel64\vc15\tbbmalloc_proxy.exp
Copy-Item build\vs2013\x64\Release\tbbmalloc_proxy.iobj -Destination C:\thirdparty\vs2017\x64\tbb-2018_U2\lib\intel64\vc15\tbbmalloc_proxy.iobj
Copy-Item build\vs2013\x64\Release\tbbmalloc_proxy.ipdb -Destination C:\thirdparty\vs2017\x64\tbb-2018_U2\lib\intel64\vc15\tbbmalloc_proxy.ipdb
Copy-Item build\vs2013\x64\Release\tbbmalloc_proxy.lib -Destination C:\thirdparty\vs2017\x64\tbb-2018_U2\lib\intel64\vc15\tbbmalloc_proxy.lib
Copy-Item build\vs2013\x64\Release\tbbmalloc_proxy.map -Destination C:\thirdparty\vs2017\x64\tbb-2018_U2\lib\intel64\vc15\tbbmalloc_proxy.map
Copy-Item build\vs2013\x64\Release\tbbmalloc_proxy.pdb -Destination C:\thirdparty\vs2017\x64\tbb-2018_U2\lib\intel64\vc15\tbbmalloc_proxy.pdb