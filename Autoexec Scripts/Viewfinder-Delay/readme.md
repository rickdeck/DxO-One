## Change Switch-to-Viewfinder Delay
At later Firmware-versions, DxO-ONE got a tiny viewfinder for its OLED. The Viewfinder is available by swiping [down] on the OLED display.

To promote usage of the feature, the camera automatically switches to this viewfinder after no input is made for 5 seconds.
This timeout value can be changed using a command.

```t dxo oled_vf_delay <value>```
<value> - Delay in milliseconds before switching to Viewfinder (default: 5000ms -> 5 seconds, off: 0)

#### Persistence:
The setting is not persistent (if the command is removed from autoexec.ash, it will reset to default on next power-on)

### Examples:
- Set delay to 10 seconds: ```t dxo oled_vf_delay 10000```
- Disable auto-switching: ```t dxo oled_vf_delay 0```
