IF EXIST C:\dev\BlueFramework\ (set BLUEFRAMEWORK_ROOT_DIR=C:\dev\BlueFramework\)
IF EXIST E:\dev\BlueFramework\ (set BLUEFRAMEWORK_ROOT_DIR=E:\dev\BlueFramework\)
echo %BLUEFRAMEWORK_ROOT_DIR%

IF EXIST C:\dev\OpenInfraPlatform\ (set OIP_ROOT_DIR=C:\dev\OpenInfraPlatform\)
IF EXIST E:\dev\OpenInfraPlatform\ (set OIP_ROOT_DIR=E:\dev\OpenInfraPlatform\)
echo %OIP_ROOT_DIR%

call "C:\Program Files (x86)\Microsoft Visual Studio\2017\Enterprise\VC\Auxiliary\Build\vcvarsall.bat" amd64
cmake -G"Visual Studio 15 2017 Win64" -H%OIP_ROOT_DIR% -BC:\build\vs2017\x64\OpenInfraPlatform ^
-DBlueFramework_DIR=%BLUEFRAMEWORK_ROOT_DIR% ^
-DOIP_USE_PREBUILD_EARLYBINDING_LIBS=false
C:
cd C:\build\vs2017\x64\OpenInfraPlatform
cmake --build . --config Debug --target OpenInfraPlatform.UI
cmake --build . --config RelWithDebInfo --target OpenInfraPlatform.UI
cmake --build . --config Release --target OpenInfraPlatform.UI