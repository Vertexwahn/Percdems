wget.exe http://vertexwahn.de/libs/json_spirit_v4.08.zip -OC:\thirdparty\vs2015\x64\json_spirit_v4.08.zip
7za.exe x C:\thirdparty\vs2015\x64\json_spirit_v4.08.zip -oC:\thirdparty\vs2015\x64
del C:\thirdparty\vs2015\x64\json_spirit_v4.08.zip
C:
cd C:\thirdparty\vs2015\x64\json_spirit_v4.08
cmake ^
-G "Visual Studio 14 2015 Win64" ^
-HC:\thirdparty\vs2015\x64\json_spirit_v4.08 ^
-BC:\thirdparty\vs2015\x64\json_spirit_v4.08\build ^
-DBoost_INCLUDE_DIR="C:\thirdparty\vs2015\x64\boost_1_64_0"
cd C:\thirdparty\vs2015\x64\json_spirit_v4.08\build
call "C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\vcvarsall.bat" amd64
devenv json_spirit.sln /build Debug /project json_spirit
devenv json_spirit.sln /build Release /project json_spirit