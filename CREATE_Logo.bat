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
set id7=BQ_Aquaris_X5_Plus
set id8=Obi_Worldphone_MV1

del /Q temp\* >NUL 2>NUL
set bpp=3
set pix_fmt=bgr24
set width=720
set height_pp=1280

if %file%=="" exit

:: To extact filesize and filename without extension
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
echo.7. BQ Aquaris X5 Plus
echo.8. Obi Worldphone MV1
echo.9. Exit
echo.
choice /n /m "Select A Menu Number:" /C:123456789
if errorlevel 1 set id=1
if errorlevel 2 set id=2
if errorlevel 3 set id=3
if errorlevel 4 set id=4
if errorlevel 5 set id=5
if errorlevel 6 set id=6
if errorlevel 7 set id=7
if errorlevel 8 set id=8
if errorlevel 9 set id=9
if %id%==9 exit
set tmp=id%id%
call set "device_name=%%%tmp%%%"
echo.
echo.
echo.Selected Device: %id%. %device_name%
echo.
pause
set output_file=%in_filedevice_name%_%device_name%.img
if %id%==1 call :YUPHORIA
if %id%==2 call :YUNIQUE
if %id%==3 call :YUTOPIA
if %id%==4 call :WILEYFOX_SWIFT
if %id%==5 call :WILEYFOX_STORM
if %id%==6 call :ZUK_Z1
if %id%==7 call :BQ_AQUARIS_X5_PLUS
if %id%==8 call :OBI_WORLDPHONE_MV1

call :IMGtoRAW
call :RAWtoRLE
call :CHECK_IF_SUCCESSFUL

echo.&echo.&set /P INPUT=Do you want to create a flashable zip? [yes/no]
If /I "%INPUT%"=="y" call :CREATE_ZIP
If /I "%INPUT%"=="yes" call :CREATE_ZIP

echo.&echo.&pause
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

:BQ_AQUARIS_X5_PLUS
set width=1080
set height_pp=1920
goto :eof

:OBI_WORLDPHONE_MV1
set width=720
set height_pp=1280
goto :eof

:IMGtoRAW
echo.&echo.&echo.Converting Pictures to RAW files.....
echo.

bin\ffmpeg.exe -hide_banner -loglevel quiet -i %file% -s %width%x%height_pp% -f rawvideo -vcodec rawvideo -pix_fmt bgr24 -y "temp\pic1.raw" > NUL
bin\ffmpeg.exe -hide_banner -loglevel quiet -i stock\%device_name%\2.png -s %width%x%height_pp% -f rawvideo -vcodec rawvideo -pix_fmt bgr24 -y "temp\pic2.raw" > NUL
if exist "stock\%device_name%\3.png" bin\ffmpeg.exe -hide_banner -loglevel quiet -i stock\%device_name%\3.png -s %width%x%height_pp% -f rawvideo -vcodec rawvideo -pix_fmt bgr24 -y "temp\pic3.raw" > NUL
if exist "stock\%device_name%\4.png" bin\ffmpeg.exe -hide_banner -loglevel quiet -i stock\%device_name%\4.png -s %width%x%height_pp% -f rawvideo -vcodec rawvideo -pix_fmt bgr24 -y "temp\pic4.raw" > NUL

goto :eof


:RAWtoRLE
echo.Concatenating RAW files.....
type temp\pic*.raw > temp\pic.raw 2>NUL

bin\CM_SPLASH_RGB24_converter.exe -p %id% -w %width% -h %height_pp% -o 512 -e 1 < temp\pic.raw > "output\%output_file%"
echo.&echo.
goto :eof

:CHECK_IF_SUCCESSFUL
if exist "output\%output_file%" ( echo.SUCCESS!&echo.%output_file% created in "output" folder
) else (echo.PROCESS FAILED.. Try Again&echo.&echo.&pause&exit)
goto :eof


:CREATE_ZIP
copy /Y bin\New_Splash.zip output\flashable_splash.zip >NUL
copy /Y output\%output_file% temp\splash.img >NUL
cd output
..\bin\7za a flashable_splash.zip ..\temp\splash.img >NUL
cd..

if exist "output\flashable_splash.zip" (
 echo.&echo.&echo.SUCCESS!
 echo.Flashable zip file created in "output" folder
 echo.You can flash the flashable_splash.zip from any custom recovery like TWRP or CWM or Philz
) else ( echo.&echo.&echo Flashable ZIP not created.. )

goto :eof