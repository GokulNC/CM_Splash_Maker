@echo off
set file=%1

%~d0
cd "%~dp0"
if not exist "temp\" mkdir "temp\"
if not exist "output\" mkdir "output\"
if not exist "output\extracted_logo\" mkdir "output\extracted_logo\"

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

for %%? in (%file%) do set /a "in_filesize=%%~z?" &set "in_filename=%%~n?" &set "ext=%%~x?"
set raw_file="temp\%in_filename%.raw"

echo.
echo.CM Splash Extractor
echo.
echo.
echo.EXTRACTING SPLASH IMAGE from %file% and CONVERTING to %in_filename%.PNG picture
:menu
echo.
echo.
echo.SELECT YOUR DEVICE:
echo.
echo.1. Yu Yuphoria
echo.2. Yu Yunique
echo.3. Yu Yutopia
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
call :RLEtoRAW
call :RAWtoPNG
echo.Extraction Complete. Picture can be found in output/extracted_logo folder
echo.
echo.
pause
del /Q temp\*
explorer .\output\extracted_logo
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


:RLEtoRAW
echo.
echo.
echo.Converting RLE to RAW file......
bin\CM_SPLASH_RGB24_converter.exe -p %id% -w %width% -h %height_pp% -o 512 -d 1 < %file% > %raw_file%
goto :eof

:RAWtoPNG
for %%? in (%raw_file%) do set /a "raw_filesize=%%~z?"
set /a total_height=%raw_filesize%/%width%/%bpp%

echo.
echo.Converting RAW image to PNG file.....
echo.
echo.
bin\ffmpeg.exe -hide_banner -loglevel quiet -f rawvideo -vcodec rawvideo -pix_fmt %pix_fmt% -s %width%x%total_height% -i %raw_file% -vframes 1 -y "output\extracted_logo\%in_filename%_%device_name%.png"
goto :eof