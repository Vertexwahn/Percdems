C:
cd C:\apps
git clone --recursive https://bitbucket.org/wkjarosz/hdrview.git
cd hdrview
mkdir build
cd build
cmake  -G"Visual Studio 15 2017 Win64" ../  ^
-DBoost_INCLUDE_DIR="C:\thirdparty\vs2017\x64\boost_1_65_0" ^
-DUSE_BOOST_REGEX=true
cmake --build . --config Release --target HDRView