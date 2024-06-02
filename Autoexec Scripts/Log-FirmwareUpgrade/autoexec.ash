# Script to enable logging of relevant modules to trace the firmware-upgrade process

t dxo console 8
# t dxo fw_version > c:\fwver.txt

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

dmesg rtos -500 > c:\dmesglog_rtos.txt
