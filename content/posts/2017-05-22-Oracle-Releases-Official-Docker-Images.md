---
date: 2017-05-22T19:02:32+02:00
title: "Lets try the official Oracle Docker container"
---

[a month ago](https://www.oracle.com/corporate/pressrelease/docker-oracle-041917.html) Oracle released official Docker images for use by developers. The images are usable on any public cloud or on premise, bare metal servers. Reason enough for me to take them for a spin.

## Prerequisites
 * [A Docker account](https://store.docker.com/signup?next=%2F);
 * A Linux VM;

Note that the beauty of Docker makes it irrelevant which Linux distribution you use. It is recommended to make sure the kernel is fairly recent and a current version of Docker is installed. For this blog, I used a 8GB ram virtual private server offered by [Digital Ocean](https://digitalocean.com) as they offer a one click Ubuntu 17.04 deployment with Docker preloaded, and this option will cost me $0.25 tops.

If you want to build your own virtual server locally and you use a RedHat like distribution, you might want to steal the script below. This is what I use for VirtualBox images I build with Vagrant.

```
#!/bin/bash

# This script installs the latest version of docker on Oracle Linux 7

cat >/etc/yum.repos.d/docker.repo <<-EOF
[dockerrepo]
name=Docker Repository
baseurl=https://yum.dockerproject.org/repo/main/oraclelinux/7
enabled=1
gpgcheck=1
gpgkey=https://yum.dockerproject.org/gpg
EOF

sudo yum update -y
sudo yum install -y docker-engine
sudo systemctl enable docker.service

sudo usermod -aG docker vagrant # Change this to your user

exit 0
```

I wanted a bit more memory for this experiment though so I opted for the Cloud.

## Run Oracle in a container
After you secured a Docker account and a machine with Docker Engine installed, it is time to start playing.

Let's start with opening an ssh session and verify which Docker versions we are running for client and server.

```
root@OracleDockerTest:~# docker version
Client:
 Version:      17.05.0-ce
 API version:  1.29
 Go version:   go1.7.5
 Git commit:   89658be
 Built:        Thu May  4 22:10:54 2017
 OS/Arch:      linux/amd64

Server:
 Version:      17.05.0-ce
 API version:  1.29 (minimum version 1.12)
 Go version:   go1.7.5
 Git commit:   89658be
 Built:        Thu May  4 22:10:54 2017
 OS/Arch:      linux/amd64
 Experimental: false
```

Ok, now that's out of the way, we need to login. Normally when I pull a Docker container, it is some open source container on the [Docker Hub](https://hub.docker.com) which you can download without authentication. Oracle requires you to agree to their [Oracle Technology Network License Agreement](http://www.oracle.com/technetwork/licenses/standard-license-152015.html).

So let's do just that:
```
root@OracleDockerTest:~# docker login -u blangenberg
Password:
Login Succeeded
```

You now need to go to the Docker store and 'purchase' the image. This is free for development usage. Fill out your details and accept the license agreement if you wish to do so.

After that's done, it's time to pull the image:
```
root@OracleDockerTest:~# docker pull store/oracle/database-enterprise:12.1.0.2
12.1.0.2: Pulling from store/oracle/database-enterprise
ac7c7887f8c8: Pull complete
81ec3f704f3a: Pull complete
fd46874fc55d: Pull complete
8f5143a7a3c5: Pull complete
0ef133fdc901: Extracting [=======>                                           ]  710.2MB/4.873GB
```

Trying to pull before you entered your details on the website will fail your pull. I tried to do this.

```
root@OracleDockerTest:~# docker pull store/oracle/database-enterprise:12.1.0.2
Error response from daemon: repository store/oracle/database-enterprise not found: does not exist or no pull access
```

The image is pretty big. 5GB in size makes this the biggest container I have ever downloaded.

```
root@OracleDockerTest:~# docker pull store/oracle/database-enterprise:12.1.0.2
12.1.0.2: Pulling from store/oracle/database-enterprise
ac7c7887f8c8: Pull complete
81ec3f704f3a: Pull complete
fd46874fc55d: Pull complete
8f5143a7a3c5: Pull complete
0ef133fdc901: Pull complete
Digest: sha256:9eab68c8857582d6aac6757b51a884e4c4f86f93e2f70815dd34004e15ec9b27
Status: Downloaded newer image for store/oracle/database-enterprise:12.1.0.2
```

```
root@OracleDockerTest:~# docker images
REPOSITORY                         TAG                 IMAGE ID            CREATED             SIZE
ubuntu                             latest              ebcd9d4fca80        7 days ago          118MB
ubuntu                             xenial              ebcd9d4fca80        7 days ago          118MB
ubuntu                             trusty              2ff3b426bbaa        7 days ago          188MB
alpine                             latest              02674b9cb179        12 days ago         3.99MB
**store/oracle/database-enterprise   12.1.0.2            235e2a33ea76        4 weeks ago         5.27GB**
```

We now need to prepare an environment file. The Oracle container will take the configuration specified in this file and use it to setup your container. Below you can find mine, which is hardly modified from the example the Docker store provides you with.

```
####################################################################
## Copyright(c) Oracle Corporation 1998,2016. All rights reserved.##
##                                                                ##
##                   Docker OL7 db12c dat file                    ##
##                                                                ##
####################################################################

##------------------------------------------------------------------
## Specify the basic DB parameters
##------------------------------------------------------------------

## db sid (name)
## default : ORCL
## cannot be longer than 8 characters

DB_SID=OraTest

## db passwd
## default : Oracle

DB_PASSWD=MyPasswd123

## db domain
## default : localdomain

DB_DOMAIN=ora.homecooked.nl

## db bundle
## default : basic
## valid : basic / high / extreme
## (high and extreme are only available for enterprise edition)

DB_BUNDLE=basic

## end
```

We are now ready for prime time.

```
root@OracleDockerTest:~# docker run -d --env-file env -p 1521:1521 -p 5500:5500 -it --name OraTest --shm-size="6g" store/oracle/database-enterprise:12.1.0.2
7e041e72c7fe966e4a8c3822f6ac9e0f906b56eefdaf945e96e33da429003258
```

env is the name of the file I created with the settings. I opened a listener on port 1521 and a webinterface on 5500. All pretty standard. My VPS has 8GB of ram, so I gave 6GB to Oracle.

```
root@OracleDockerTest:~# docker ps
CONTAINER ID        IMAGE                                       COMMAND                  CREATED              STATUS              PORTS                                            NAMES
7e041e72c7fe        store/oracle/database-enterprise:12.1.0.2   "/bin/sh -c '/bin/..."   About a minute ago   Up About a minute   0.0.0.0:1521->1521/tcp, 0.0.0.0:5500->5500/tcp   OraTest
```

I was immediately able to connect using SQL Developer

<img src="../img/dockerconnect.png" width="1000">

Note that Enterprise Manager Express also worked out of the box but i was unable to use it. All three of my browsers complained I had no flash installed. Didn't bother to investigate the issue.

With this article as a reference, I will be able to setup an Oracle development environment on DigitalOcean in ~15 minutes, which is the fastest option I have in my tool belt today. Pretty impressive and straight forward!
