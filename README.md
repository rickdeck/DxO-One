# DxO-One Preservation Project
Unofficial, collected information about the (discontinued) DxO-One Camera, a tiny camera with a 1" Sony Sensor and f/1.8 lens. 

Contribution is very welcome!

## Table of Contents
1. Hardware
   1. BOM (Hardware Bill-Of-Material)
3. Software
   1. Ambarella RTOS
   2. Linux OS
   3. Firmware binary Analysis
4. Smartphone App

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

Ambarella OS has a own shell which can accept commands, but as the device is missing a UART-port I didn't find a way so far to connect to it (I still suspect that it's possible to switch the USB-Port to UART, but I haven't found a method yet.


### Ambarella RTOS
#### autoexec.ash:
On power-on (sliding the lens-cover open or connecting USB), the OS looks for the file autoexec.ash on the SD-Card and, if it exists, executes the shell-commands in it on the RTOS.
This allows to do a few interesting things, such as enabling logging, switching USB-Modes, executing commands, etc.

> [!IMPORTANT]
> 1. autoexec.ash needs to be stored at the root of the microSD-card (together with the DCIM-Folder)
> 2. Line-breaks need to be in Unix-format (LF, not CR LF)
> 3. Each command must be finished with a line-break, so the last line of the file should be empty.

To start investigating the Device, the first step is to re-route logging to a file stored on SD-card.

<details>
  <summary>Log RTOS to SD-card</summary>

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
- section_1 - (unconfirmed) DSP Firmware
- section_2 - Ambarella ROMFS
- section_3 - Linux kernel (unconfirmed)
- section_4 - Linux userspace (unconfirmed)
- section_5 - Firmware-Update OS (unconfirmed)

# Smartphone App
There's a Smartphone App accompanying the Device for iOS, and an Android-App for the (later) USB-C version of the camera.

## Connect DxO-One with Lightning Port to the Android App
There is a way to connect the Apple-variant of DxO-ONE to the Android App (assumed here that the Android device has a USB-C port, but it would also work with micro-USB).

Possibly, this could work with a lightning port to USB-C adapter (not tested, happy to hear if someone tried it), but there is a way to do this via the microUSB port on the back of the device.

**1. Required Hardware:**
 1. Android Smartphone with USB-C OTG support
 2. USB-C OTG to USB-Female Adapter
 3. USB to microUSB cable

> [!NOTE]
> The two cables can also be replaced with a single USB-C OTG to microUSB cable, like [this]( https://sunguy.com/collections/micro-usb-cable/products/sunguy-micro-usb-to-usb-c-right-angle-cable-b030bc-charging-cable-wholesale-customized ) one.

**2. Prepare DxO-ONE:**
<details>
  <summary>1. Add autoexec.ash file to SD-card</summary>
    
   A script on the SD-card will be executed on power-on of the camera and will redirect the USB-connection of the Lightning port to the microUSB (disabling Mass-Storage support on the microUSB port).
   The setting is permanent (the command only needs to be executed once), so to revert it again another command needs to be sent,
   
   You can download both of them here: [Enable Lightning via microUSB]( https://github.com/rickdeck/DxO-One/blob/main/Autoexec%20Scripts/AndroidApp-Enable), [Disable Lightning via microUSB]( https://github.com/rickdeck/DxO-One/blob/main/Autoexec%20Scripts/AndroidApp-Disable )

    ```
    # Enable Lightning via microUSB
    t dxo micro_usb_connected_toggle on
    t dxo iap2_toggle off
    
    # Disable Lightning via microUSB (remove leading # to apply)
    # t dxo micro_usb_connected_toggle off
    # t dxo iap2_toggle auto
    ```
  
</details>
 
**3. Connect devices:**
1. Install the DxO-ONE App from Google Play Store
2. Connect USB-C OTG to USB adapter with MicroUSB cable connected to it
3. Switch-on the DXO-ONE (open lens-cover)
4. Connect microUSB cable to DXO-ONE
5. Confirm on your Smartphone which App should be opened for this device (select DXO-ONE App)

If everything works as expected, the app will launch, connect to the camera and switch to the viewfinder.

**Limitations:**
1. Wi-Fi connection between Smartphone and DXO-ONE doesn't work (apparently some protocol-issue I didn't look into yet)
2. Not really convenient to use as viewfinder, but good to change settings on the camera (current app-setting is preserved by the camera and kept after disconnecting)


## Developer Mode
There is a hidden Developer Mode in the Android App, which doesn't really serve much of a purpose at this moment. It could however be interesting to learn about the communication between app and Camera.

<details>
  <summary>Enter Developer Mode</summary>

  1. Start application without Camera connected
  2. On the "Please connect your DxO ONE" Screen, tap 10x in lower right corner of the screen
  3. (Developer Menu opens)  
</details>

<details>
  <summary>Quit Developer Mode</summary>
  
To quit the Developer Mode, you need to disconnect the activated cameras again.
1. Open Settings-Menu (top-left Gallery button, then select top-left hamburger icon)
2. Select [Developer Menu]
3. Disable enabled Camera-Simulators
</details>

<details>
  <summary>Content of Developer Mode Menu</summary>
  
  ### **1. Camera Simulator**
  
  Closed-loop simulator of Camera communication (the App will behave like its connected to a camera, and the simulated Camera will reply as expected with the defined latency)
  
  **App-Options:**
  1. Connect with Camera Simulator (On/Off)
  2. Simulator communication latency
  
  ### **2. Raspberry Pi Camera Server**
  
  App will (try to) reach a Raspberry Pi on the local network which runs a (unknown DxO-proprietary) Camera Server to communicate with. Unfortunately there is no image publicly available of Raspberry Pi to respond correctly.
  
  **App-Options:**
  1. Connect with Pi Camera Server (On/Off)
  2. Host (Select Hostname to connect to)
  
  ### **3. Others**
  **App-Options:**
  1. Crash the App!

</details>
