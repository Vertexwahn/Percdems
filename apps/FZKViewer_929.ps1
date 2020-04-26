Invoke-WebRequest https://www.iai.kit.edu/downloads/Informatik_fuer_die_Energiesystemanalyse/FZKViewer-4.8_Build-929.zip -OutFile C:\apps\FZKViewer-4.8_Build-929.zip

# Extract file
$strFileName="$env:ProgramFiles\7-Zip\7z.exe"
If (Test-Path $strFileName){
	# Use 7-zip
	if (-not (test-path "$env:ProgramFiles\7-Zip\7z.exe")) {throw "$env:ProgramFiles\7-Zip\7z.exe needed"} 
	set-alias sz "$env:ProgramFiles\7-Zip\7z.exe"  
	sz x C:\apps\FZKViewer-4.8_Build-929.zip -oC:\apps\FZKViewer-4.8_Build-929
} Else {
	# use slow Windows stuff
	Expand-Archive C:\apps\FZKViewer-4.8_Build-929.zip -DestinationPath C:\apps\FZKViewer-4.8_Build-929
}

# Removed downloaded zip archive
Remove-Item C:\apps\FZKViewer-4.8_Build-929.zip