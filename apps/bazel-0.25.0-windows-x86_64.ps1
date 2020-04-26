[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
Invoke-WebRequest https://github.com/bazelbuild/bazel/releases/download/0.25.0/bazel-0.25.0-windows-x86_64.zip -OutFile C:\apps\bazel-0.25.0-windows-x86_64.zip

# Extract file
$strFileName="$env:ProgramFiles\7-Zip\7z.exe"
If (Test-Path $strFileName){
	# Use 7-zip
	if (-not (test-path "$env:ProgramFiles\7-Zip\7z.exe")) {throw "$env:ProgramFiles\7-Zip\7z.exe needed"} 
	set-alias sz "$env:ProgramFiles\7-Zip\7z.exe"  
	sz x C:\apps\bazel-0.25.0-windows-x86_64.zip -oC:\apps\bazel-0.25.0-windows-x86_64
} Else {
	# use slow Windows stuff
	Expand-Archive C:\apps\bazel-0.25.0-windows-x86_64.zip -DestinationPath C:\apps\bazel-0.25.0-windows-x86_64
}

# Removed downloaded zip archive
Remove-Item C:\apps\bazel-0.25.0-windows-x86_64.zip