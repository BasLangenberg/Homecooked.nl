---
date: 2016-08-15T19:02:32+02:00
title: "How to build vim from scratch"
---

I ran into a problem this weekend. I was unable to compile Vim with Python 2 support on a virtual machine I upgraded earlier from Ubuntu 14.04 to 16.04. In Ubuntu 16.04, Python 2 is not installed by default anymore, so Vim is also compiled without support for this language.

Sadly, my Vim setup requires Python 2 to be available since I use 2 plugins which rely on it. YouCompleteMe and Ultisnip, yet replacable, are staples in my Vimming. Also I don't like it to get dictated on what I can and I can't use.

So here you'll find Bas' guide to compile Vim up from source and package it as a .deb.

### Compile Vim

You can find the instructions [here](https://github.com/Valloric/YouCompleteMe/wiki/Building-Vim-from-source). I executed this on a Digital Ocean droplet running Ubuntu 16.04. You can get coupons for 10 dollar credit everywhere on the entire internet, so this doesn't have to cost you anything if you don't want to spend any money. If you do not want to use a cloud service to build an arbitrary binary, you can use a local VM or whatnot.

1. Install dependencies

        sudo apt-get install libncurses5-dev libgnome2-dev libgnomeui-dev \
            libgtk2.0-dev libatk1.0-dev libbonoboui2-dev \
            libcairo2-dev libx11-dev libxpm-dev libxt-dev python-dev \
            python3-dev ruby-dev git

2. Remove vim

        sudo apt-get remove vim vim-runtime gvim

3. Download source and compile

        cd ~
        git clone https://github.com/vim/vim.git
        cd vim
        ./configure --with-features=huge \
                    --enable-multibyte \
                    --enable-rubyinterp \
                    --enable-pythoninterp \
                    --with-python-config-dir=/usr/lib/python2.7/config-x86_64-linux-gnu \
                    --enable-python3interp \
                    --with-python3-config-dir=i/usr/lib/python3.5/config-3.5m-x86_64-linux-gnu \
                    --enable-perlinterp \
                    --enable-luainterp \
                    --enable-gui=gtk2 --enable-cscope --prefix=/usr
        make VIMRUNTIMEDIR=/usr/share/vim/vim74
        sudo make install

Please note that I had to change the --with-python-config-dir flags for both versions of Python. This USED to work as described in the readme of YCM, but something changed in the packaging. Look for config.c in the target dir, and make sure to not end with a /.

So much for simplified instructions. After your compilation went well, let's package this piece of binary up and deploy it to some machines!

### Package Vim

We're not trying to get into Debian or some flavour of RHEL. This is just for me, so let's take the easy route. [Jordan Sissel](https://github.com/jordansissel) wrote the excellent [fpm](https://github.com/jordansissel/fpm) program which I've used before to easily package rpms and debs from source.

1. Setup Ruby and install fpm

        apt-get install ruby-dev gcc make
        gem install fpm

2. Package Vim

        fpm -s dir -t deb -n vim74 ~/vim/
        # Output:
        
        Debian packaging tools generally labels all files in /etc as config files, as mandated by policy, so fpm defaults to this behavior for deb packages. You can disable this default behavior with --deb-no-default-config-files flag {:level=>:warn}
        Debian packaging tools generally labels all files in /etc as config files, as mandated by policy, so fpm defaults to this behavior for deb packages. You can disable this default behavior with --deb-no-default-config-files flag {:level=>:warn}
        Created package {:path=>"vim74_1.0_amd64.deb"}
        root@vim-build-server:~# ll
        total 83480
        drwx------  6 root root     4096 Aug 15 20:12 ./
        drwxr-xr-x 23 root root     4096 Aug 15 19:08 ../
        -rw-r--r--  1 root root      220 Aug 31  2015 .bash_logout
        -rw-r--r--  1 root root     3771 Aug 31  2015 .bashrc
        drwx------  2 root root     4096 Aug 15 19:55 .cache/
        -rw-r--r--  1 root root        0 Aug 10 19:50 .cloud-locale-test.skip
        drwxr-xr-x  3 root root     4096 Aug 15 20:09 .gem/
        -rw-r--r--  1 root root      655 Jun 24 15:44 .profile
        drwx------  2 root root     4096 Aug 15 19:08 .ssh/
        drwxr-xr-x  9 root root     4096 Aug 15 20:00 vim/
        -rw-r--r--  1 root root 85443742 Aug 15 20:12 vim74_1.0_amd64.deb

Seriously, I LOVE fpm. I don't use it that often, maybe once or twice a year, but this piece of code is so usefull when you want to package up something you compiled from source I want to marry it. I use it at work to build and deploy non standard versions of Python too.

### Testing the package

I scp'd the package to a local directory and spinned up another instance of Ubuntu 16.04 at Digital Ocean to test this.

```sh
sudo dpkg -i vim74_1.0_amd64.deb
```

Voila! Vim works, and has Python2 support enabled!

