---
date: 2015-06-08T19:02:32+02:00
title: Sending data through the air
---

Although I was very happy with my new arch box, something was off. I had to keep my laptop at the kitchen table when using it. Why, you might ask?

Because my ethernet cable was there, and wireless was not working out of the box. I was a bit stumbled by that. Nevertheless, challenge accepted...

Investigation showed why this is not working out of the box. I had to install a [package](https://aur.archlinux.org/packages/b43-firmware/) from the Arch User Repository (AUR) as the firmware necessary for my Broadcom wireless adapter was a closed source blob. The driver is in the kernel, only the firmware was missing. The first step was installing the AUR helper of choice. I want to spend time figuring out which one to use, but I took [Yaourt](https://archlinux.fr/yaourt-en) anyway, since I did not want to spend a lot of time on this trivial topic. I do not plan on using a lot of AUR packages anyway, next to Gnome skins. Installing Yaourt is very easy. I did not want to clutter my Pacman configuration file with an unsupported repo, so I manually build it.

    curl -O https://aur.archlinux.org/packages/pa/package-query/package-query.tar.gz
    tar zxvf package-query.tar.gz
    cd package-query
    makepkg -si
    cd ..
    curl -O https://aur.archlinux.org/packages/ya/yaourt/yaourt.tar.gz
    tar zxvf yaourt.tar.gz
    cd yaourt
    makepkg -si
    cd ..

All was working fine now regarding the AUR. What I did next was:

1. Install the appropriate driver using Yaourt
2. Enable and start Network Manager
3. Using Gnome's Network applet, find my Wifi network and connect using the credentials I already knew

.. That's it. I didn't had any prior Wifi experience on Linux, as I only use cable connected servers in my daily business. It's pretty interesting that some manual labor is necessary to get something trivial to work, but I won't hold it against Arch as I knew what I was up to. 

Another lesson learned!
