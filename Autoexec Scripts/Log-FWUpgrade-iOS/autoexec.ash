# Script to switch Device-port to microUSB and enable logging of relevant modules, to trace the firmware-upgrade process

t dxo console 8
# t dxo fw_version > c:\fwver.txt

# Disable routing to microUSB (persistent change)
t dxo micro_usb_connected_toggle off
t dxo iap2_toggle auto

# Enable relevant logging
t t wifi 1
t t usbx 1
t t usb_debug 1
t t update 1
t t update_debug 1
t t protocol 1
t t protocol_debug 1
t t ipclinux 1
t t ipclinux_debug 1
t t ui 1
t t ui_debug 1

dmesg rtos -1000 > c:\dmesglog_rtos.txt
