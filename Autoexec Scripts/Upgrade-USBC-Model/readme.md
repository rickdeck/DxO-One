## Fix Shipping-State of DxO-One USB-C
Purpose of this package is to upgrade a DxO-One USB-C Variant from its initial shipping state to a recent firmware

> [!IMPORTANT]
> This script is NOT for the iOS-Variant of the DxO-One! Do not attempt to use it!


### 1. Initial Shipping State
When purchasing DxO-One USB-C Variants online, you may receive a device which resembles a swap-unit (without accessories or sales-box).
These devices only have an initial firmware, where the camera itself is working, but the USB-C connection to the DxO-One Android-App doesn't work.


### 2. How to fix that 
The files in this folder contain a script for the SD-card which performs a partial Upgrade of the OS (which contains an internal FW-upgrade routine) and proceed to a full upgrade of all partitions 

<ins>Contents:</ins>
* `autoexec.ash` : Startup script which will trigger `flash.ash`, correct an incorrect iAP-setting and store a logfile of the operation.
* `flash.ash` : Script which will write 'AmbaSysFW.bin' to the Flash-Memory and then delete itself.
* `AmbaSysFW.bin` : Recent RTOS-Firmware which includes capabilities to upgrade whole firmware from SD.
* `DXOSYS_3.2.0.12504d1481.BIN` : Complete Firmware for DxO-One USB-C Variant.


### 3. Preparation steps
1. Copy all files to the root of a microSD card (either from this folder or download the latest release as [zip]( https://github.com/rickdeck/DxO-One/releases/tag/USBC-bringup )
2. Properly eject the microSD from your PC
3. Insert microSD into the USB-C DxO-One
4. Connect DxO-One to a microUSB-charger (NOT a USB Data cable!)

   Device will start charging and then move to a upgrade process, restarting several times
   A **checkmark will be shown when all is complete** and camera will start charging again
5. (Insert microSD in your PC), delete the remaining files on the microSD again (`autoexec.ash`, `AmbaSysFW.bin`)

**If you see a checkmark, the upgrade is complete and you are able to use the camera normally.**

(The DxO-One Android App may still indicate that a newer firmware is available, which you can also upgrade.)


### 4. What will happen
When connecting the device to the charger, the following procedure will be performed
1. **Device boots up and starts charging**
2. **Device starts upgrading, showing progress-bar** (`autoexec.ash` was executed, triggering `flash.ash` which writes `AmbaSysFW.bin` to Flash and deletes itself)
3. **Device reboots** (Writing was finished, Camera restarts with new RTOS-Firmware)
4. **Device charges again** (a few seconds)
5. **Device starts full FW-upgrade, showing progress-bar** (RTOS completed booting, `autoexec.ash` is executed again, `flash.ash` doesn't exist anymore but iAP-parameter is written. RTOS finds `DXOSYS_3.2.0.12504d1481.BIN` and starts internal upgrade)
6. **Device reboots** (first step of full Firmware-Upgrade completed)
7. **Device continues upgrade, showing progress-bar** (Screen flickers during this step)
8. **Checkmark is shown** (internal upgrade is completed, camera shuts down)
9. **Device starts charging** (charger triggered startup of device)


### 5. If something goes wrong
1. (Insert microSD in your PC), copy `console_debug.txt`, `dmesglog_rtos.txt` and `firmfl.txt` to your PC.
2. Make a ZIP-file with all files
3. Raise an issue [here](https://github.com/rickdeck/DxO-One/issues) with the zip-file describing your pain.

Thanks!
