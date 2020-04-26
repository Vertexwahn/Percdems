wget.exe http://zlib.net/zlib1211.zip -OC:\thirdparty\vs2017\x64\zlib-1.2.11.zip
7za.exe x C:\thirdparty\vs2017\x64\zlib-1.2.11.zip -oC:\thirdparty\vs2017\x64
del C:\thirdparty\vs2017\x64\zlib-1.2.11.zip
call "C:\Program Files (x86)\Microsoft Visual Studio\2017\Enterprise\VC\Auxiliary\Build\vcvarsall.bat" amd64
cmake -G"Visual Studio 15 2017 Win64" -HC:\thirdparty\vs2017\x64\zlib-1.2.11 -BC:\thirdparty\vs2017\x64\zlib-1.2.11\build
C:
cd C:\thirdparty\vs2017\x64\zlib-1.2.11\build
cmake --build . --config Debug
cmake --build . --config Release
cmake --build . --config RelWithDebInfo
mkdir C:\thirdparty\vs2017\x64\zlib-1.2.11\lib
mkdir C:\thirdparty\vs2017\x64\zlib-1.2.11\bin
copy Debug\zlibd.dll C:\thirdparty\vs2017\x64\zlib-1.2.11\bin\zlibd.dll
copy Debug\zlibd.exp C:\thirdparty\vs2017\x64\zlib-1.2.11\lib\zlibd.exp
copy Debug\zlibd.ilk C:\thirdparty\vs2017\x64\zlib-1.2.11\lib\zlibd.ilk
copy Debug\zlibd.lib C:\thirdparty\vs2017\x64\zlib-1.2.11\lib\zlibd.lib
copy Debug\zlibd.pdb C:\thirdparty\vs2017\x64\zlib-1.2.11\lib\zlibd.pdb
copy Debug\zlibstaticd.lib C:\thirdparty\vs2017\x64\zlib-1.2.11\lib\zlibstaticd.lib
copy Release\zlib.dll C:\thirdparty\vs2017\x64\zlib-1.2.11\bin\zlib.dll
copy Release\zlib.exp C:\thirdparty\vs2017\x64\zlib-1.2.11\lib\zlib.exp
copy Release\zlib.lib C:\thirdparty\vs2017\x64\zlib-1.2.11\lib\zlib.lib
copy Release\zlibstatic.lib C:\thirdparty\vs2017\x64\zlib-1.2.11\lib\zlibstatic.lib
copy zconf.h C:\thirdparty\vs2017\x64\zlib-1.2.11\zconf.h