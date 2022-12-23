---
title: "How to remap your caps lock to an additional left control in Windows 10"
date: 2018-10-05T17:00:00+02:00
---
I always remap my capslock to an additional control. Since I googled how to do this for the 1000th time today, I'd like to document this on my blog.

1. Create a capslock-to-control.reg file somewhere on your computer
2. Add the following content:

```
REGEDIT4

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Keyboard Layout]
"Scancode Map"=hex:00,00,00,00,00,00,00,00,02,00,00,00,1d,00,3a,00,00,00,00,00
```

3. Apply the file to the registry by double clicking and confirming the change
4. Reboot
5. Yer done!

Hope this helps someone out. It sure will help me out in the future when touching a Windows 10 box for the first time again.
