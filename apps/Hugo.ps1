# Now download boost 1.64.0
Invoke-WebRequest https://github.com/gohugoio/hugo/releases/download/v0.24.1/hugo_0.24.1_Windows-64bit.zip -OutFile C:\apps\hugo_0.24.1_Windows-64bit.zip

# Extract file
$strFileName="$env:ProgramFiles\7-Zip\7z.exe"
If (Test-Path $strFileName){
	# Use 7-zip
	if (-not (test-path "$env:ProgramFiles\7-Zip\7z.exe")) {throw "$env:ProgramFiles\7-Zip\7z.exe needed"} 
	set-alias sz "$env:ProgramFiles\7-Zip\7z.exe"  
	sz x C:\apps\hugo_0.24.1_Windows-64bit.zip -oC:\apps\hugo
} Else {
	# use slow Windows stuff
	Expand-Archive C:\apps\hugo_0.24.1_Windows-64bit.zip -DestinationPath C:\apps\hugo
}

# Removed downloaded zip archive
Remove-Item C:\apps\hugo_0.24.1_Windows-64bit.zip