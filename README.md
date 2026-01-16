# SundanceInH2A - Linux

Run iOS 6 on your iPod touch 3 (with Linux)!

Apple never released iOS 6 for iPod touch 3rd-generation (2009). 13 years later [nyan_satan](https://github.com/NyanSatan) decided to fix it

This repository contains tools and instructions to *convert* iPhone 3GS iOS 6 firmware to iPod touch 3 compatible firmware and run it untethered

[Demo video on YouTube](https://www.youtube.com/watch?v=VTbShvf97kI)

**Important note**: this is potentially DANGEROUS. Make sure you read this text *very* attentively - especially **Precautions** & **Known issues** sections. I'm not responsible for any damage this tool and knowledge can cause

![](repo/demo.jpg)

## Changelog
<details>

### rev1-linux
* Everything from v3
  * All executables ported to Linux
     * Both jailbroken and normal KernelCache are now added.

### rev3
* Firmware patch metadata went to separate configs
    * This allows you to use multiple different base IPSW combinations
        * ...and even add your own by filling a corresponding config file

    * Added code to automatically fix code-signature of patched Mach-Os
        * So you don't have to hardcode new page hashes into such configs

* Newly supported configs are iOS 6.1.3 (10B329) & 6.1.6 (10B500)

* Added lock screen overlay image for Wallpaper preference bundle

* Embedded executables now can run on as low as Mac OS X 10.7

### rev2b
* Fixed the bug when unclean shutdown (such as via hard reset) would break the untether

### rev2a
* Fixed Wi-Fi on **CH**-region iPods by disabling WAPI

### rev2
* Added jailbreak option (`-j` flag)

### rev1a
* Fixed the exploit to work on iPod touch 3's with 4096 bytes block size NANDs

* Unlimited `absinthed` & `securekeyvaultd` daemons (were limited to iPhone 3GS by default)
    * They are something related to device attestation, DRM and etc.
    * IDK if it actually improves something, hopefully doesn't break anything at least

### rev1
* Initial release

</details>

## Technical write-up
[Here](https://nyansatan.github.io/run-unsupported-ios)

## Tutorial

### Requirements
* A computer running Ubuntu 23.04 or newer

* Python 3.7+

* User capable of using terminal

### Prerequisites
* Files from this repository

* iPhone 3GS iOS 6 IPSW. Supported builds:
    1. [6.0 (10A403)](https://secure-appldnld.apple.com/iOS6/Restore/041-7173.20120919.sDDMh/iPhone2,1_6.0_10A403_Restore.ipsw)
    2. [6.1.3 (10B329)](https://secure-appldnld.apple.com/iOS6.1/091-2371.20130319.715gt/iPhone2,1_6.1.3_10B329_Restore.ipsw)
    3. [6.1.6 (10B500)](https://secure-appldnld.apple.com/iOS6.1/091-3457.20140221.Btt3e/iPhone2,1_6.1.6_10B500_Restore.ipsw)

* iPod touch 3 iOS 5.1.1 (9B206) [IPSW](https://secure-appldnld.apple.com/iOS5.1.1/041-4300.20120427.WvgGq/iPod3,1_5.1.1_9B206_Restore.ipsw)

* I've added both normal and jailbroken KernelCache, so kernelcache step was removed.
   * However, you can run this command to rebuild KernelCache:
   ```shell
   ➜  SundanceInH2A-Linux git:(master) ✗ ./refresh-kernelcache.sh
   ```
   
   

* Pwned DFU tool
    * You can use [Legacy iOS Kit](https://github.com/LukeZGD/Legacy-iOS-Kit) for this step.

### Steps

0. Change working directory to the downloaded repo and execute:

    ```shell
    ➜  SundanceInH2A-Linux git:(master) ✗ ./Sundancer iPod3,1_5.1.1_9B206_Restore.ipsw iPhone2,1_6.x_10YNNN_Restore.ipsw iPod3,1_6.x_10YNNN_Custom
    ```

    Add `-j` option to apply jailbreak (on **rev2** and later)

    Change the paths accordingly, of course

    If it all goes well, after 30 seconds (or up to 3-4 minutes on older hardware) you will see a new directory - `iPod3,1_6.x_10YNNN_Custom`. This is our new restore bundle - basically an unpacked IPSW (luckily, modern `idevicerestore` can process those)

    Log sample:

    ```shell
    ➜  SundanceInH2A-Linux git:(master) ✗ ./Sundancer iPod3,1_5.1.1_9B206_Restore.ipsw iPhone2,1_6.0_10A403_Restore.ipsw iPod3,1_6.0_10A403_Custom
    |  0.002 |  processing iOS 5 iBoots
    |  0.014 |  packaging kernelcache
    |  1.183 |  packaging DeviceTree
    |  1.187 |  extracting iOS 5 root filesystem
    |  3.938 |  extracting WLAN & multitouch firmwares
    |  3.963 |  extracting Bluetooth firmware
    |  3.971 |  extracting iOS 6 root filesystem
    |  7.567 |  removing OTA update files
    |  7.703 |  patching dyld shared cache
    |  8.094 |  patching FairPlay LaunchDaemon
    |  8.265 |  packaging iOS 6 root filesystem
    | 32.929 |  extracting iOS 6 ramdisk
    | 32.985 |  growing ramdisk
    | 32.987 |  patching ASR
    | 33.002 |  replacing rc.boot
    | 33.014 |  putting exploit.dmg
    | 33.021 |  moving options plist
    | 33.024 |  packaging iOS 6 ramdisk
    | 33.033 |  assembling bundle
    | 33.129 |  wrote BuildManifest
    | 33.132 |  DONE!
    ```

1. Enter pwned DFU on your iPod touch 3
    1. First, enter normal bootrom DFU (involves pressing and holding Home and Power buttons - there are plenty of guides online)
    2. Then use [Legacy iOS Kit](https://github.com/LukeZGD/Legacy-iOS-Kit) to enter pwned DFU mode.

    ```shell
    # This part will be updated when I obtain an iPod Touch 3, be patient.
    ➜  SundanceInH2A-Linux git:(master) ✗ iPwnder32 -p
    ** iPwnder32 - RELEASE v3.2.0 [3C152] by @dora2ios
    Waiting for device in DFU mode...
    DFU device infomation iPod Touch (3rd gen) [iPod3,1]
    CPID:0x8922 CPRV:0x02 BDID:0x02 ECID:0xXXXXXXXXXXXXXXXX CPFM:0x03 SCEP:0x01 IBFL:0x00
    SRTG:[iBoot-359.5] 
    exploiting with limera1n
    * based on limera1n exploit (heap overflow) by geohot
    Device is now in pwned DFU mode!
    ```

3. Start restore! `idevicerestore` is provided by this repo under `executables/`

    ```shell
    ➜  SundanceInH2A-Linux git:(master) ✗ executables/idevicerestore -ey iPod3,1_6.x_10YNNN_Custom
    ```

Restore is going to take around 5 minutes. If everything goes well, you'll end up on iOS 6 setup screen

Please note that iOS 6 is very ancient at this point, so most online services (both Apple's and 3rd-party) are not gonna work. You can still activate the device though

## Downgrade tutorial
The iBoot exploit used for the untether needs `boot-partition` NVRAM variable set to `2` to activate. It will break iOS 5.1.1 if set this way, and old iOS versions are dumb enough to NOT erase the variable upon restore

[nyan_satan](https://github.com/NyanSatan) patched iBEC to allow arbitrary NVRAM variable change, so you can remove it without much hassle

1. Create a custom iOS 6 restore bundle if not already

2. Enter pwned DFU

3. Start a restore, but kill `idevicerestore` immediately after it finished uploading iBEC

4. Your iPod should light up its' display and appear on USB

5. Now you need `irecovery` which is included in `executables/`

    ```shell
    # reset the variable
    irecovery -c "setenv boot-partition"

    # synchronize NVRAM
    irecovery -c "saveenv"

    # reboot the device
    irecovery -c "reboot"
    ```

6. At this point, the variable should have gone away and you can restore iOS 5.1.1

## Boot-args/verbose boot
The iBoot exploit makes it respect NVRAM boot-args, so you can set `-v` to make kernel print boot logs to screen, for instance

Enter recovery mode and execute commands below:

```shell
# set desired args
irecovery -c "setenv boot-args -v"

# synchronize NVRAM
irecovery -c "saveenv"

# set "auto-boot" to "true" and reboot the device
irecovery -n
```

`amfi=0xff` and `launchctl_enforce_codesign=0` are always added automatically by the exploit's shellcode to disable Mach-O codesigning and LaunchDaemon signed cache (on iOS 6.1.x)

## Precautions

* This is unholy mix of DEVELOPMENT kernel, DeviceTree diffs and custom iBoot patches - I highly doubt anything *bad* can happen, but...

* Wi-Fi, Bluetooth & multitouch firmwares are taken from iOS 5 - they seem to behave sanely, but...

* Even though [nyan_satan](https://github.com/NyanSatan) tested it quite well, there still might be various issues. Let me know if you find any

* This tool uses an iBoot bug (HFS+ extent buffer overflow) to make it run untethered. [nyan_satan](https://github.com/NyanSatan) never encountered any issues with the current implementation of the exploit, but they still might happen making your device enter a boot loop - nothing irreversible though - see **Downgrade tutorial**

## Known issues

* Sometimes, Wi-Fi reconnects every minute or so
    * Might be related to [nyan_satan](https://github.com/NyanSatan)'s router (I didn't test it on mine as I don't have an iPod Touch 3 right now, but I will update later)

* Built-in speaker seems to be less loud compared to iOS 5
    * Headphones work fine
    * Probably related to missing hardware-specific plists in `MediaToolbox` framework

* Bluetooth audio devices cannot actually play
    * Seems to be related to `VirtualAudio` bundle, and it's a mess

## Credits

* **planetbeing**, **dborca**, **xerub** - for XPwn tools
* **pimskeks** and other people behind **libimobiledevice** project - for libirecovery & idevicerestore
* **Me (MKstarFromSwitch)** and **LukeZGD** - Luke for Legacy iOS Kit, me for porting and adding KernelCache files made by **nyan_satan**
