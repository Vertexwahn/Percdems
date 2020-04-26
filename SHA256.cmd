@echo off
REM The MIT License (MIT)
REM 
REM Copyright (c) 2014 Vasil Arnaudov
REM 
REM Permission is hereby granted, free of charge, to any person obtaining a copy
REM of this software and associated documentation files (the "Software"), to deal
REM in the Software without restriction, including without limitation the rights
REM to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
REM copies of the Software, and to permit persons to whom the Software is
REM furnished to do so, subject to the following conditions:
REM 
REM The above copyright notice and this permission notice shall be included in all
REM copies or substantial portions of the Software.
REM 
REM THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
REM IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
REM FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
REM AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
REM LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
REM OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
REM SOFTWARE.

REM Modified by Julian Amann - modidfications also under MIT license

setlocal enableDelayedExpansion
if "%~1" equ "" (
	echo no file passed
	echo pass -help to see the help message
	exit /b 1
)

for %%# in (-h -help /h /help) do (
	if "%~1" equ "%%~#" (
		echo generates SHA256 checksum for a given file
		(echo()
		echo USAGE:
		(echo()
		echo %~nx0 file [variable]
		(echo()
		echo variable string in which the generated checksum will be stored
		(echo()
		exit /b 0
	)
)

if not exist "%~1" (
	echo file %~1 does not exist
	exit /b 2
)

if exist "%~1\" (
	echo %~1 is a directory
	exit /b 3
)

for %%# in (certutil.exe) do (
	if not exist "%%~f$PATH:#" (
		echo no certutil installed
		echo for Windows XP professional and Windows 2003
		echo you need Windows Server 2003 Administration Tools Pack
		echo https://www.microsoft.com/en-us/download/details.aspx?id=3725
		exit /b 4
	)
)

set "SHA256="
for /f "skip=1 tokens=* delims=" %%# in ('certutil -hashfile "%~f1" SHA256') do (
	if not defined SHA256 (
		for %%Z in (%%#) do set "SHA256=!SHA256!%%Z"
	)
)

if "%~2" neq "" (
	endlocal && (
		set "%~2=%SHA256%"
	) 
) else (
	echo %SHA256%
)
endlocal