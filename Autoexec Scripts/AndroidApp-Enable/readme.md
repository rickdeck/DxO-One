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
  1. Add `autoexec.ash` file to SD-card

     A script on the SD-card will be executed on power-on of the camera and will redirect the USB-connection of the Lightning port to the microUSB (disabling Mass-Storage support on the microUSB port).
   > [!IMPORTANT]
   > The setting is permanent (the command only needs to be executed once), so to disable it again, the disable-script needs to be executed,
   
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

**4. Limitations:**
1. Wi-Fi connection between Smartphone and DXO-ONE doesn't work (apparently some protocol-issue I didn't look into yet)
2. Not really convenient to use as viewfinder, but good to change settings on the camera (current app-setting is preserved by the camera and kept after disconnecting)
