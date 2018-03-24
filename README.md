# CM Splash Maker

A tool to change the bootlogo for the following devices:

[BQ Aquaris X5 Plus](https://forum.xda-developers.com/android/development/guide-how-to-change-splash-screen-boot-t3710111)<br/>
[Lenovo Zuk Z1](http://forum.xda-developers.com/zuk-z1/general/guide-how-to-create-custom-splash-t3429718)<br/>
Obi Worldphone MV1<br/>
[Wileyfox Storm](http://forum.xda-developers.com/wileyfox-storm/general/guide-how-to-create-custom-splash-t3429715)<br/>
[Wileyfox Swift](http://forum.xda-developers.com/wileyfox-swift/general/guide-how-to-create-custom-splash-t3427143)<br/>
[Yu Yuphoria, Yunique & Yutopia](http://forum.xda-developers.com/yu-yuphoria/general/custom-splash-screens-boot-logo-yuphoria-t3402521/post67407050#post67407050)

This can no longer be used for any new devices I think, since [Cyanogen is shut down](https://google.com/search?q=cyanogen+shutdown) :sob:<br/>
(This type of splash.img was for devices that shipped with Cyanogen OS)

### How to run

#### Creating a splash.img :

Just drag and drop your bootlogo file on the `CREATE_Logo.bat` file, and then select your device as prompted.<br/>
After the bootlogo is created, it will automatically be in `output` folder.<br/>
You can also generate a flashable ZIP file now which can be flashed from custom recovery.

If you want to flash from fastboot:
```batch
fastboot flash splash filename.img
```

If you want to flash from the Terminal Emulator in your Android device:
```sh
su
dd if=/sdcard/filename.img of=/dev/block/bootdevice/by-name/splash
```

If you want to flash from ADB:
```sh
adb push filename.img /sdcard/filename.img
adb shell su -c dd if=/sdcard/filename.img of=/dev/block/bootdevice/by-name/splash
```

#### Extracting a splash.img :

To backup your stock splash.img to your Android device:
```sh
su
dd if=/dev/block/bootdevice/by-name/splash of=/sdcard/stock_splash.img
```

To backup your stock splash.img to your via ADB:
```sh
adb shell su -c dd if=/dev/block/bootdevice/by-name/splash of=/sdcard/stock_splash.img
adb pull /sdcard/stock_splash.img stock_splash.img
```

To extract it, just drag and drop it on the `EXTRACT_Logo.bat` file and then select your device as prompted.<br/>