# DxO-One Preservation Project
Unofficial, collected information about the (discontinued) DxO-One Camera, a tiny camera with a 1" Sony Sensor and f/1.8 lens. 

Contribution is very welcome!

## Table of Contents
1. Hardware
   1. BOM (Hardware Bill-Of-Material)
2. Software
   1. Ambarella RTOS
   2. Linux OS
   3. Firmware binary Analysis
3. Interesting things
   1. Connect DxO-One with Lightning Port to the Android App

More information is available in the [wiki](https://github.com/rickdeck/DxO-One/wiki).

## Hardware BOM & Details
- **ODM Manufacturer:** Ability Enterprise Co., Ltd TAIWAN
- **FCC ID:** 2AAD3JA0J0M0

<details>
  <summary>BOM Details</summary>

  | Role          | Supplier | Component           | Comment|
  | ------------- |:-------------:|:-------------:|:-------------:|
  | SoC | Ambarella | A9-A1-RH S1433 N93WA-D ANM1N1 A9S35 |
  | Audio | Analog Devices | ADAU1382 BCPZ | Audio Stereo codec (for Microphone input) |
  | NAND storage | SPANSION | ML04G200BH100 |
  | DRAM | SAMSUNG | K4P8G304E0-AGC2 |
  | Gyroscope | Invensense | MPU6500 |
  | Accelerometer | ST | ITG1020 |
  | Battery | Unknown | 17360 750mAh 3.7V (with soldered cables) |
  | Wi-Fi | Broadcom | Azurewave BCM43340(?) abgn+BT+FM+NFC |
  | Wi-Fi Power Aplifier? | Novatek | NT11004 1416-BG HOA7800| Located on Wi-Fi board|
</details>

## Software

The device is using Ambarella RTOS as its main OS for controlling the camera hardware and OLED display, and a separate Linux OS to control Wi-Fi functions.
This is a quite popular chipset for (older) GoPro and other Action Camera clones as well as many Dashcams.

It seems that in case of the DxO-One, the Linux OS is mostly suspended and only woken up on-demand to connect to Wi-Fi. It might be interesting to achieve a shell to this OS, as it could allow adding wireless features (like FTP-transfer of images or 3rd party Wi-Fi control)

Ambarella OS has a own shell which can accept commands, but as the device is missing a UART-port I didn't find a way so far to connect to it (I suspect that it's possible to switch the USB-Port to UART, but I haven't found a method yet).


### Ambarella RTOS
#### autoexec.ash:
On power-on (sliding the lens-cover open or connecting USB), the OS looks for the file `autoexec.ash` on the SD-Card and, if it exists, executes the shell-commands in it on the RTOS.
This allows to do a few interesting things, such as enabling logging, switching USB-Modes, executing commands, etc.

> [!IMPORTANT]
> 1. `autoexec.ash` needs to be stored at the root of the microSD-card (together with the DCIM-Folder)
> 2. Line-breaks need to be in Unix-format (LF, not CR LF)
> 3. Each command must be finished with a line-break, so the last line of the file should be empty.

To start investigating the Device, the first step is to re-route logging to a file stored on SD-card.

<details>
  <summary>Log RTOS to SD-card</summary>

   Download here: [Log-to-SD]( https://github.com/rickdeck/DxO-One/tree/main/Autoexec%20Scripts/Log-to-SD )
  ```
  t dxo console 8
  (empty)
  ```
  When this file is saved on the root of the SD-card, on next power-on of the camera it will log its operation to the file console_debug.txt in the root of the microSD

</details>

## Firmware binary Analysis
The mobile App contains the firmware binary to update devices with older versions.

- **Latest version:** 3.2.0
- **Binary name:** DXOSYS_3.2.0.ecef5ef809.BIN
- **Path within iPhone app:** /DxO ONE.app/Firmware

Unpacking the binary with gopro-fw-tools ( https://github.com/evilwombat/gopro-fw-tools ) reveals 6 files:
- section_0 - Ambarella RTOS
- section_1 - DSP Microcode
- section_2 - Ambarella ROMFS
- section_3 - Linux kernel
- section_4 - Linux Root FS
- section_5 - Firmware-Update OS

# Interesting things
There's a Smartphone App accompanying the Device for iOS, and an Android-App for the (later) USB-C version of the camera.

## Connect DxO-One with Lightning Port to the Android App
There is a way to connect the Apple-variant of DxO-ONE to the Android App (assumed here that the Android device has a USB-C port, but it would also work with micro-USB).

Possibly, this could work with a lightning port to USB-C adapter (not tested, happy to hear if someone tried it), but there is a way to do this via the microUSB port on the back of the device.

See here: [Enable Lightning via microUSB]( https://github.com/rickdeck/DxO-One/blob/main/Autoexec%20Scripts/AndroidApp-Enable), [Disable Lightning via microUSB]( https://github.com/rickdeck/DxO-One/blob/main/Autoexec%20Scripts/AndroidApp-Disable )

**Limitations:**
1. Wi-Fi connection between Smartphone and DXO-ONE doesn't work (apparently some protocol-issue I didn't look into yet)
2. Not really convenient to use as viewfinder, but good to change settings on the camera (current app-setting is preserved by the camera and kept after disconnecting)
