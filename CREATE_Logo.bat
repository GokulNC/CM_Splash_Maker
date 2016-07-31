@echo off
set file=%1

%~d0
cd "%~dp0"
if not exist "temp\" mkdir "temp\"
if not exist "output\" mkdir "output\"

set id1=Yuphoria
set id2=Yunique
set id3=Yutopia
set id4=Wileyfox_Swift
set id5=Wileyfox_Storm
set id6=Zuk_Z1

del /Q temp\* >NUL 2>NUL
set bpp=3
set pix_fmt=bgr24
set width=720
set height_pp=1280

if %file%=="" exit

for %%? in (%file%) do set /a "in_filesize=%%~z?" &set "in_filedevice_name=%%~n?" &set "ext=%%~x?"

echo.
echo.CM Splash Maker By GokulNC
echo.
echo.
echo.CREATING Splash from %file% picture and ENCODING to %in_filedevice_name%.img
:menu
echo.
echo.
echo.SELECT YOUR DEVICE:
echo.
echo.1. Yu YUPHORIA
echo.2. Yu YUNIQUE
echo.3. Yu YUTOPIA
echo.4. Wileyfox Swift
echo.5. Wileyfox Storm
echo.6. Zuk Z1
echo.9. Exit
echo.
choice /n /m "Select A Menu Number:" /C:1234569
if errorlevel 1 set id=1
if errorlevel 2 set id=2
if errorlevel 3 set id=3
if errorlevel 4 set id=4
if errorlevel 5 set id=5
if errorlevel 6 set id=6
if errorlevel 9 set id=9
if %id%==9 exit
set tmp=id%id%
call set "device_name=%%%tmp%%%"
echo.
echo.
echo.Selected Device: %id%. %device_name%
echo.
pause
if %id%==1 call :YUPHORIA
if %id%==2 call :YUNIQUE
if %id%==3 call :YUTOPIA
if %id%==4 call :WILEYFOX_SWIFT
if %id%==5 call :WILEYFOX_STORM
if %id%==6 call :ZUK_Z1

call :IMGtoRAW
call :RAWtoRLE

pause
del /Q temp\*
explorer .\output
exit


:YUPHORIA
set width=720
set height_pp=1280
goto :eof

:YUNIQUE
set width=720
set height_pp=1280

goto :eof

:YUTOPIA
set width=1440
set height_pp=2560
goto :eof

:WILEYFOX_SWIFT
set width=720
set height_pp=1280
goto :eof

:WILEYFOX_STORM:
set width=1080
set height_pp=1920
goto :eof

:ZUK_Z1
set width=1080
set height_pp=1920
goto :eof


:IMGtoRAW
echo.
echo.
echo.Converting Pictures to RAW files.....
echo.

bin\ffmpeg.exe -hide_banner -loglevel quiet -i %file% -f rawvideo -vcodec rawvideo -pix_fmt bgr24 -y "temp\pic1.raw" > NUL
bin\ffmpeg.exe -hide_banner -loglevel quiet -i stock\%device_name%\2.png -f rawvideo -vcodec rawvideo -pix_fmt bgr24 -y "temp\pic2.raw" > NUL
bin\ffmpeg.exe -hide_banner -loglevel quiet -i stock\%device_name%\3.png -f rawvideo -vcodec rawvideo -pix_fmt bgr24 -y "temp\pic3.raw" > NUL
if exist "stock\%device_name%\4.png" bin\ffmpeg.exe -hide_banner -loglevel quiet -i stock\%device_name%\4.png -f rawvideo -vcodec rawvideo -pix_fmt bgr24 -y "temp\pic4.raw" > NUL

goto :eof


:RAWtoRLE
echo.Concatenating RAW files.....
type temp\pic*.raw > temp\pic.raw 2>NUL

bin\CM_SPLASH_RGB24_converter.exe -p %id% -w %width% -h %height_pp% -o 512 -e 1 < temp\pic.raw > "output\%in_filedevice_name%_%device_name%.img"
echo.Splash Logo Created in /output folder for %device_name%
echo.
echo.
goto :eof