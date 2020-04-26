IF EXIST C:\dev\BlueFramework\ (set BLUEFRAMEWORK_ROOT_DIR=C:\dev\BlueFramework\)
IF EXIST E:\dev\BlueFramework\ (set BLUEFRAMEWORK_ROOT_DIR=E:\dev\BlueFramework\)
echo %BLUEFRAMEWORK_ROOT_DIR%

call "C:\Program Files (x86)\Microsoft Visual Studio\2017\Enterprise\VC\Auxiliary\Build\vcvarsall.bat" amd64
cmake -G"Visual Studio 15 2017 Win64" -H%BLUEFRAMEWORK_ROOT_DIR% -BC:\build\vs2017\x64\BlueFramework
C:
cd C:\build\vs2017\x64\BlueFramework
cmake --build . --config Debug --target UpdateLibsAndDLLsForCurrentBuildConfiguration
cmake --build . --config RelWithDebInfo --target UpdateLibsAndDLLsForCurrentBuildConfiguration
cmake --build . --config Release --target UpdateLibsAndDLLsForCurrentBuildConfiguration