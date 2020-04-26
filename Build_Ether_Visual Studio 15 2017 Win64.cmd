IF EXIST C:\dev\BlueFramework\ (set BLUEFRAMEWORK_ROOT_DIR=C:\dev\BlueFramework\)
IF EXIST E:\dev\BlueFramework\ (set BLUEFRAMEWORK_ROOT_DIR=E:\dev\BlueFramework\)
echo %BLUEFRAMEWORK_ROOT_DIR%

IF EXIST C:\dev\Ether\ (set OIP_ROOT_DIR=C:\dev\Ether\)
IF EXIST E:\dev\Ether\ (set OIP_ROOT_DIR=E:\dev\Ether\)
echo %OIP_ROOT_DIR%

call "C:\Program Files (x86)\Microsoft Visual Studio\2017\Enterprise\VC\Auxiliary\Build\vcvarsall.bat" amd64
cmake -G"Visual Studio 15 2017 Win64" -H%OIP_ROOT_DIR% -BC:\build\vs2017\x64\Ether ^
-DBlueFramework_DIR=%BLUEFRAMEWORK_ROOT_DIR%
cmake -G"Visual Studio 15 2017 Win64" -H%OIP_ROOT_DIR% -BC:\build\vs2017\x64\Ether ^
-DBlueFramework_DIR=%BLUEFRAMEWORK_ROOT_DIR%
C:
cd C:\build\vs2017\x64\Ether

cmake --build . --config Debug --target Ether.EtherDebugApiV1_0
cmake --build . --config RelWithDebInfo --target Ether.EtherDebugApiV1_0
cmake --build . --config Release --target Ether.EtherDebugApiV1_0

cmake --build . --config Debug --target Ether.DebugVisualizer
cmake --build . --config RelWithDebInfo --target Ether.DebugVisualizer
cmake --build . --config Release --target Ether.DebugVisualizer

cmake --build . --config Debug --target Ether.EtherDebugApiV1_0
cmake --build . --config RelWithDebInfo --target Ether.EtherDebugApiV1_0
cmake --build . --config Release --target Ether.EtherDebugApiV1_0

cmake --build . --config Debug --target Ether.RenderNode
cmake --build . --config RelWithDebInfo --target Ether.RenderNode
cmake --build . --config Release --target Ether.RenderNode

cmake --build . --config Debug --target Ether.RenderServer
cmake --build . --config RelWithDebInfo --target Ether.EtherServer
cmake --build . --config Release --target Ether.RenderServer
