---
date: 2017-01-02T19:02:32+02:00
title: "How to make systemd run a script on shutdown while networking is still there"
---

This took me way to long to sort out. In Linux, sometimes you want to make sure a script is ran which interacts with a service on the network or internet. This means that when the shutdown or reboot sequence is started, it needs to run before the networking services are stopped.

So just in case I forget how to do this or someone else is in dire need this functionality, please find the solution for my problem below.

```
[Unit]
Description=Notify something on the network before shutdown
After=network.target
Before=shutdown.target reboot.target

[Service]
Type=oneshot
RemainAfterExit=true
ExecStop=/path/to/my/script.sh

[Install]
WantedBy=multi-user.target
```
