wget.exe https://github.com/openexr/openexr/archive/v2.2.0.zip -OC:\thirdparty\vs2017\x64\openexr-2.2.0.zip
7za.exe x C:\thirdparty\vs2017\x64\openexr-2.2.0.zip -oC:\thirdparty\vs2017\x64
del C:\thirdparty\vs2017\x64\openexr-2.2.0.zip
C:
cd C:\thirdparty\vs2017\x64\openexr-2.2.0\IlmBase
cmake -DCMAKE_INSTALL_PREFIX="C:\thirdparty\vs2017\x64\openexr-2.2.0\deploy" ^
-G "Visual Studio 15 2017 Win64" ^
 ..\ilmbase
setlocal
del /f CMakeCache.txt
cmake -DCMAKE_INSTALL_PREFIX="..\deploy" -G "Visual Studio 15 2017 Win64" ..\ilmbase
cmake --build . --config Release
cmake --build . --config RelWithDebInfo
cmake --build . --config Debug
cmake --build . --target INSTALL
cd C:\thirdparty\vs2017\x64\openexr-2.2.0\OpenEXR
setlocal
del /f CMakeCache.txt
cmake -DZLIB_ROOT="C:\thirdparty\vs2017\x64\zlib-1.2.11" ^
-DILMBASE_PACKAGE_PREFIX="C:\thirdparty\vs2017\x64\openexr-2.2.0\deploy" ^
-DCMAKE_INSTALL_PREFIX="..\deploy" ^
-G "Visual Studio 15 2017 Win64" ^
..\openexr

mkdir C:\thirdparty\vs2017\x64\openexr-2.2.0\OpenEXR\IlmImf\Release
copy C:\thirdparty\vs2017\x64\openexr-2.2.0\deploy\lib\Half.dll          C:\thirdparty\vs2017\x64\openexr-2.2.0\OpenEXR\IlmImf\Release\Half.dll
copy C:\thirdparty\vs2017\x64\openexr-2.2.0\deploy\lib\Iex-2_2.dll       C:\thirdparty\vs2017\x64\openexr-2.2.0\OpenEXR\IlmImf\Release\Iex-2_2.dll 
copy C:\thirdparty\vs2017\x64\openexr-2.2.0\deploy\lib\IexMath-2_2.dll   C:\thirdparty\vs2017\x64\openexr-2.2.0\OpenEXR\IlmImf\Release\IexMath.2_2.dll
copy C:\thirdparty\vs2017\x64\openexr-2.2.0\deploy\lib\IlmThread-2_2.dll C:\thirdparty\vs2017\x64\openexr-2.2.0\OpenEXR\IlmImf\Release\IlmThread-2_2.dll
copy C:\thirdparty\vs2017\x64\openexr-2.2.0\deploy\lib\Imath-2_2.dll     C:\thirdparty\vs2017\x64\openexr-2.2.0\OpenEXR\IlmImf\Release\Imath-2_2.dll

mkdir C:\thirdparty\vs2017\x64\openexr-2.2.0\OpenEXR\IlmImf\RelWithDebInfo
copy C:\thirdparty\vs2017\x64\openexr-2.2.0\deploy\lib\Half.dll          C:\thirdparty\vs2017\x64\openexr-2.2.0\OpenEXR\IlmImf\RelWithDebInfo\Half.dll
copy C:\thirdparty\vs2017\x64\openexr-2.2.0\deploy\lib\Iex-2_2.dll       C:\thirdparty\vs2017\x64\openexr-2.2.0\OpenEXR\IlmImf\RelWithDebInfo\Iex-2_2.dll 
copy C:\thirdparty\vs2017\x64\openexr-2.2.0\deploy\lib\IexMath-2_2.dll   C:\thirdparty\vs2017\x64\openexr-2.2.0\OpenEXR\IlmImf\RelWithDebInfo\IexMath.2_2.dll
copy C:\thirdparty\vs2017\x64\openexr-2.2.0\deploy\lib\IlmThread-2_2.dll C:\thirdparty\vs2017\x64\openexr-2.2.0\OpenEXR\IlmImf\RelWithDebInfo\IlmThread-2_2.dll
copy C:\thirdparty\vs2017\x64\openexr-2.2.0\deploy\lib\Imath-2_2.dll     C:\thirdparty\vs2017\x64\openexr-2.2.0\OpenEXR\IlmImf\RelWithDebInfo\Imath-2_2.dll

mkdir C:\thirdparty\vs2017\x64\openexr-2.2.0\OpenEXR\IlmImf\Debug
copy C:\thirdparty\vs2017\x64\openexr-2.2.0\deploy\lib\Half.dll          C:\thirdparty\vs2017\x64\openexr-2.2.0\OpenEXR\IlmImf\Debug\Half.dll
copy C:\thirdparty\vs2017\x64\openexr-2.2.0\deploy\lib\Iex-2_2.dll       C:\thirdparty\vs2017\x64\openexr-2.2.0\OpenEXR\IlmImf\Debug\Iex-2_2.dll 
copy C:\thirdparty\vs2017\x64\openexr-2.2.0\deploy\lib\IexMath-2_2.dll   C:\thirdparty\vs2017\x64\openexr-2.2.0\OpenEXR\IlmImf\Debug\IexMath.2_2.dll
copy C:\thirdparty\vs2017\x64\openexr-2.2.0\deploy\lib\IlmThread-2_2.dll C:\thirdparty\vs2017\x64\openexr-2.2.0\OpenEXR\IlmImf\Debug\IlmThread-2_2.dll
copy C:\thirdparty\vs2017\x64\openexr-2.2.0\deploy\lib\Imath-2_2.dll     C:\thirdparty\vs2017\x64\openexr-2.2.0\OpenEXR\IlmImf\Debug\Imath-2_2.dll

cmake --build . --config Release
cmake --build . --config RelWithDebInfo
cmake --build . --config Debug
cmake --build . --target INSTALL