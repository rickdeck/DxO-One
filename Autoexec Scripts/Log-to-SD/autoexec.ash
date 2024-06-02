# Enable routing of logs to SDcard, dump RTOS dmesg log, log firmware version

t dxo console 8
dmesg rtos -1000 > c:\dmesglog_rtos.txt
t dxo fw_version > c:\fwver.txt
