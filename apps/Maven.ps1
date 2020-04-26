# Now download boost 1.64.0
Invoke-WebRequest http://www-eu.apache.org/dist/maven/maven-3/3.5.0/binaries/apache-maven-3.5.0-bin.zip -OutFile C:\apps\apache-maven-3.5.0-bin.zip

# Extract file
$strFileName="$env:ProgramFiles\7-Zip\7z.exe"
If (Test-Path $strFileName){
	# Use 7-zip
	if (-not (test-path "$env:ProgramFiles\7-Zip\7z.exe")) {throw "$env:ProgramFiles\7-Zip\7z.exe needed"} 
	set-alias sz "$env:ProgramFiles\7-Zip\7z.exe"  
	sz x C:\apps\apache-maven-3.5.0-bin.zip -oC:\apps
} Else {
	# use slow Windows stuff
	Expand-Archive C:\apps\apache-maven-3.5.0-bin.zip -DestinationPath C:\apps
}

# Removed downloaded zip archive
Remove-Item C:\apps\apache-maven-3.5.0-bin.zip