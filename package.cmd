@echo off > nul
if exist stereo-quake.zip del stereo-quake.zip
if exist package-temp rmdir package-temp /s /q
mkdir package-temp
chdir package-temp
mkdir Quake
mkdir Quake2
copy ..\Quake\Release\*.exe Quake
copy ..\Quake2\quake2-3.21\release\*.exe Quake2
copy ..\Quake2\quake2-3.21\release\*.dll Quake2
copy ..\Quake\gnu.txt
7z a -r -mx=9 ..\stereo-quake.zip .
chdir ..
rmdir package-temp /s /q