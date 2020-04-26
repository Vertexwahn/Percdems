# Now download boost 1.64.0
Invoke-WebRequest http://www.dependencywalker.com/depends22_x64.zip -OutFile C:\apps\depends22_x64.zip

# Extract file
$strFileName="$env:ProgramFiles\7-Zip\7z.exe"
If (Test-Path $strFileName){
	# Use 7-zip
	if (-not (test-path "$env:ProgramFiles\7-Zip\7z.exe")) {throw "$env:ProgramFiles\7-Zip\7z.exe needed"} 
	set-alias sz "$env:ProgramFiles\7-Zip\7z.exe"  
	sz x C:\apps\depends22_x64.zip -oC:\apps\depends22_x64
} Else {
	# use slow Windows stuff
	Expand-Archive C:\apps\depends22_x64.zip -DestinationPath C:\apps\depends22_x64
}

# Removed downloaded zip archive
Remove-Item C:\apps\depends22_x64.zip