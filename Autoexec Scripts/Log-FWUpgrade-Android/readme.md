## If you want to perform a Firmware-Upgrade and like to log the procedure, please follow the following process:

### Get 'Before' SW-version
1. Check your Firmware by putting the CheckFirmware Script `autoexec.ash` onto your SD-card root [here](https://github.com/rickdeck/DxO-One/tree/main/Autoexec%20Scripts/CheckFirmware)
2. Start your Camera with that SD-card inserted (=open the lens-cover), wait 2-3 seconds and power it off again (=close the lens-cover).
3. Insert microSD in your PC. If the script was correctly executed you will find a file called `fwver.txt` on your card. Save it to your PC as `fwver_before.txt`

### Enable logging and start firmware-upgrade using the App
4. Apply the Firmware-logging `autoexec.ash` script from here to your SD-card root.
5. Delete `console_debug.txt` on your microSD (if it exists), to start a new logfile.
6. Start your camera with the SD-Card inserted (=open the lens-cover)
7. Connect it to the App
8. In the App, open Gallery (top-left), then [Settings] (top-left), Firmware Upgrade and follow the process.

### Get 'After' SW-version
9. Check your Firmware by putting the CheckFirmware Script `autoexec.ash` onto your SD-card root [here](https://github.com/rickdeck/DxO-One/tree/main/Autoexec%20Scripts/CheckFirmware)
10. Start your Camera with that SD-card inserted (=open the lens-cover), wait 2-3 seconds and power it off again (=close the lens-cover).
11. Insert microSD in your PC. If the script was correctly executed you will find a file called `fwver.txt` on your card. Save it to your PC as `fwver_after.txt`

### Collect logs
12. Insert microSD in your PC, copy `console_debug.txt`, `dmesglog_rtos.txt` to your PC.
13. Make a ZIP-file with the following files:
    `console_debug.txt`
    `dmesglog_rtos.txt`
    `fwver_before.txt`
    `fwver_after.txt`
14. Comment on [this](https://github.com/rickdeck/DxO-One/issues/1) issue with your target-firmware and the zip-file
