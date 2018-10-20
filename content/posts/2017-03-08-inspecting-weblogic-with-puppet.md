---
date: 2017-03-08T19:02:32+02:00
title: "Inspecting WebLogic with Puppet"
---

Recently, I was talking with some colleagues about Puppet and the added value it brings to everything infrastructure. The reason I mostly talk about Puppet is because of the superb WebLogic and Oracle database support existing for it. There are modules for WebLogic in Chef, but these only install the software. With Puppet, you can manage much more.

A lot of other blogs mentioning Puppet mostly show how you can provision the software. In almost all of my customer cases, WebLogic is already there responsible for serving applications like SOA Suite, ADF or bespoke Java applications. Surely we should be able to show the power of Puppet on existing systems as well!

In this blog, I'm using the Oracle SOA Suite 12.1.3 box which you can readily download [here](http://www.oracle.com/technetwork/middleware/soasuite/learnmore/vmsoa1213-2660211.html). The only thing I did was starting SOA Suite using the shortcuts you can find on the desktop.

### Step 1: Install Puppet

Installing Puppet on RHEL deravitives is easy. I only needed to import the Yum repository used by Puppet (the company) to serve the RPM and after that install the Puppet agent. On the SOA Suite box I used a proxy was active preventing me to connect.

```
[oracle@soa-training ~]$ yum search puppet
Loaded plugins: refresh-packagekit, ulninfo
http://public-yum.oracle.com/repo/OracleLinux/OL6/UEK/latest/x86_64/repodata/repomd.xml: [Errno 14] PYCURL ERROR 5 - "Couldn't resolve proxy 'www-proxy.us.oracle.com'"
Trying other mirror.
Error: Cannot retrieve repository metadata (repomd.xml) for repository: public_ol6_UEK_latest. Please verify its path and try again
```

The solution for this problem was to open /etc/yum.conf and comment or delete the proxy entry in there. After I did this, we could connect to the public repositories. Make sure to accept the key Puppet uses to identify and sign their packages.

```
[root@soa-training ~]# sudo rpm -ivh https://yum.puppetlabs.com/puppetlabs-release-el-6.noarch.rpm
Retrieving https://yum.puppetlabs.com/puppetlabs-release-el-6.noarch.rpm
Preparing...                ########################################### [100%]
   1:puppetlabs-release     ########################################### [100%]
[root@soa-training ~]# yum install puppet
Loaded plugins: refresh-packagekit, ulninfo
Setting up Install Process
public_ol6_UEK_latest                                                                                                                                                                                                 | 1.2 kB     00:00     
public_ol6_UEK_latest/primary                                                                                                                                                                                         |  31 MB     00:25     
public_ol6_UEK_latest                                                                                                                                                                                                                652/652
public_ol6_addons                                                                                                                                                                                                     | 1.2 kB     00:00     
public_ol6_addons/primary                                                                                                                                                                                             | 136 kB     00:00     
public_ol6_addons                                                                                                                                                                                                                    431/431
public_ol6_latest                                                                                                                                                                                                     | 1.4 kB     00:00     
public_ol6_latest/primary                                                                                                                                                                                             |  62 MB     00:37     
public_ol6_latest                                                                                                                                                                                                                37021/37021
puppetlabs-deps                                                                                                                                                                                                       | 2.5 kB     00:00     
puppetlabs-deps/primary_db                                                                                                                                                                                            |  27 kB     00:00     
puppetlabs-products                                                                                                                                                                                                   | 2.5 kB     00:00     
puppetlabs-products/primary_db                                                                                                                                                                                        | 170 kB     00:00     
Resolving Dependencies
--> Running transaction check
---> Package puppet.noarch 0:3.8.7-1.el6 will be installed
--> Processing Dependency: ruby >= 1.8.7 for package: puppet-3.8.7-1.el6.noarch
--> Processing Dependency: ruby >= 1.8 for package: puppet-3.8.7-1.el6.noarch
--> Processing Dependency: facter >= 1:1.7.0 for package: puppet-3.8.7-1.el6.noarch
--> Processing Dependency: hiera >= 1.0.0 for package: puppet-3.8.7-1.el6.noarch
--> Processing Dependency: ruby-shadow for package: puppet-3.8.7-1.el6.noarch
--> Processing Dependency: ruby-augeas for package: puppet-3.8.7-1.el6.noarch
--> Processing Dependency: rubygem-json for package: puppet-3.8.7-1.el6.noarch
--> Processing Dependency: ruby(selinux) for package: puppet-3.8.7-1.el6.noarch
--> Processing Dependency: /usr/bin/ruby for package: puppet-3.8.7-1.el6.noarch
--> Running transaction check
---> Package facter.x86_64 1:2.4.6-1.el6 will be installed
--> Processing Dependency: pciutils for package: 1:facter-2.4.6-1.el6.x86_64
--> Processing Dependency: virt-what for package: 1:facter-2.4.6-1.el6.x86_64
---> Package hiera.noarch 0:1.3.4-1.el6 will be installed
---> Package libselinux-ruby.x86_64 0:2.0.94-7.el6 will be installed
--> Processing Dependency: libselinux = 2.0.94-7.el6 for package: libselinux-ruby-2.0.94-7.el6.x86_64
---> Package ruby.x86_64 0:1.8.7.374-4.el6_6 will be installed
--> Processing Dependency: ruby-libs = 1.8.7.374-4.el6_6 for package: ruby-1.8.7.374-4.el6_6.x86_64
--> Processing Dependency: libruby.so.1.8()(64bit) for package: ruby-1.8.7.374-4.el6_6.x86_64
---> Package ruby-augeas.x86_64 0:0.4.1-3.el6 will be installed
--> Processing Dependency: augeas-libs >= 0.8.0 for package: ruby-augeas-0.4.1-3.el6.x86_64
--> Processing Dependency: libaugeas.so.0(AUGEAS_0.11.0)(64bit) for package: ruby-augeas-0.4.1-3.el6.x86_64
--> Processing Dependency: libaugeas.so.0(AUGEAS_0.8.0)(64bit) for package: ruby-augeas-0.4.1-3.el6.x86_64
--> Processing Dependency: libaugeas.so.0(AUGEAS_0.12.0)(64bit) for package: ruby-augeas-0.4.1-3.el6.x86_64
--> Processing Dependency: libaugeas.so.0(AUGEAS_0.10.0)(64bit) for package: ruby-augeas-0.4.1-3.el6.x86_64
--> Processing Dependency: libaugeas.so.0(AUGEAS_0.1.0)(64bit) for package: ruby-augeas-0.4.1-3.el6.x86_64
--> Processing Dependency: libaugeas.so.0()(64bit) for package: ruby-augeas-0.4.1-3.el6.x86_64
---> Package ruby-shadow.x86_64 1:2.2.0-2.el6 will be installed
---> Package rubygem-json.x86_64 0:1.5.5-3.el6 will be installed
--> Processing Dependency: rubygems >= 1.3.7 for package: rubygem-json-1.5.5-3.el6.x86_64
--> Running transaction check
---> Package augeas-libs.x86_64 0:1.0.0-10.el6 will be installed
---> Package libselinux.x86_64 0:2.0.94-5.8.el6 will be updated
--> Processing Dependency: libselinux = 2.0.94-5.8.el6 for package: libselinux-utils-2.0.94-5.8.el6.x86_64
--> Processing Dependency: libselinux = 2.0.94-5.8.el6 for package: libselinux-python-2.0.94-5.8.el6.x86_64
---> Package libselinux.x86_64 0:2.0.94-7.el6 will be an update
---> Package pciutils.x86_64 0:3.1.10-4.el6 will be installed
---> Package ruby-libs.x86_64 0:1.8.7.374-4.el6_6 will be installed
--> Processing Dependency: libreadline.so.5()(64bit) for package: ruby-libs-1.8.7.374-4.el6_6.x86_64
---> Package rubygems.noarch 0:1.3.7-5.el6 will be installed
--> Processing Dependency: ruby-rdoc for package: rubygems-1.3.7-5.el6.noarch
---> Package virt-what.x86_64 0:1.11-1.2.el6 will be installed
--> Running transaction check
---> Package compat-readline5.x86_64 0:5.2-17.1.el6 will be installed
---> Package libselinux-python.x86_64 0:2.0.94-5.8.el6 will be updated
---> Package libselinux-python.x86_64 0:2.0.94-7.el6 will be an update
---> Package libselinux-utils.x86_64 0:2.0.94-5.8.el6 will be updated
---> Package libselinux-utils.x86_64 0:2.0.94-7.el6 will be an update
---> Package ruby-rdoc.x86_64 0:1.8.7.374-4.el6_6 will be installed
--> Processing Dependency: ruby-irb = 1.8.7.374-4.el6_6 for package: ruby-rdoc-1.8.7.374-4.el6_6.x86_64
--> Running transaction check
---> Package ruby-irb.x86_64 0:1.8.7.374-4.el6_6 will be installed
--> Finished Dependency Resolution

Dependencies Resolved

=============================================================================================================================================================================================================================================
 Package                                                    Arch                                            Version                                                       Repository                                                    Size
=============================================================================================================================================================================================================================================
Installing:
 puppet                                                     noarch                                          3.8.7-1.el6                                                   puppetlabs-products                                          1.6 M
Installing for dependencies:
 augeas-libs                                                x86_64                                          1.0.0-10.el6                                                  public_ol6_latest                                            315 k
 compat-readline5                                           x86_64                                          5.2-17.1.el6                                                  public_ol6_latest                                            129 k
 facter                                                     x86_64                                          1:2.4.6-1.el6                                                 puppetlabs-products                                           99 k
 hiera                                                      noarch                                          1.3.4-1.el6                                                   puppetlabs-products                                           23 k
 libselinux-ruby                                            x86_64                                          2.0.94-7.el6                                                  public_ol6_latest                                             99 k
 pciutils                                                   x86_64                                          3.1.10-4.el6                                                  public_ol6_latest                                             85 k
 ruby                                                       x86_64                                          1.8.7.374-4.el6_6                                             public_ol6_latest                                            538 k
 ruby-augeas                                                x86_64                                          0.4.1-3.el6                                                   puppetlabs-deps                                               21 k
 ruby-irb                                                   x86_64                                          1.8.7.374-4.el6_6                                             public_ol6_latest                                            317 k
 ruby-libs                                                  x86_64                                          1.8.7.374-4.el6_6                                             public_ol6_latest                                            1.7 M
 ruby-rdoc                                                  x86_64                                          1.8.7.374-4.el6_6                                             public_ol6_latest                                            380 k
 ruby-shadow                                                x86_64                                          1:2.2.0-2.el6                                                 puppetlabs-deps                                               13 k
 rubygem-json                                               x86_64                                          1.5.5-3.el6                                                   puppetlabs-deps                                              763 k
 rubygems                                                   noarch                                          1.3.7-5.el6                                                   public_ol6_latest                                            206 k
 virt-what                                                  x86_64                                          1.11-1.2.el6                                                  public_ol6_latest                                             23 k
Updating for dependencies:
 libselinux                                                 x86_64                                          2.0.94-7.el6                                                  public_ol6_latest                                            108 k
 libselinux-python                                          x86_64                                          2.0.94-7.el6                                                  public_ol6_latest                                            202 k
 libselinux-utils                                           x86_64                                          2.0.94-7.el6                                                  public_ol6_latest                                             82 k

Transaction Summary
=============================================================================================================================================================================================================================================
Install      16 Package(s)
Upgrade       3 Package(s)

Total download size: 6.6 M
Is this ok [y/N]: y
Downloading Packages:
(1/19): augeas-libs-1.0.0-10.el6.x86_64.rpm                                                                                                                                                                           | 315 kB     00:00     
(2/19): compat-readline5-5.2-17.1.el6.x86_64.rpm                                                                                                                                                                      | 129 kB     00:00     
(3/19): facter-2.4.6-1.el6.x86_64.rpm                                                                                                                                                                                 |  99 kB     00:00     
(4/19): hiera-1.3.4-1.el6.noarch.rpm                                                                                                                                                                                  |  23 kB     00:00     
(5/19): libselinux-2.0.94-7.el6.x86_64.rpm                                                                                                                                                                            | 108 kB     00:00     
(6/19): libselinux-python-2.0.94-7.el6.x86_64.rpm                                                                                                                                                                     | 202 kB     00:00     
(7/19): libselinux-ruby-2.0.94-7.el6.x86_64.rpm                                                                                                                                                                       |  99 kB     00:00     
(8/19): libselinux-utils-2.0.94-7.el6.x86_64.rpm                                                                                                                                                                      |  82 kB     00:00     
(9/19): pciutils-3.1.10-4.el6.x86_64.rpm                                                                                                                                                                              |  85 kB     00:00     
(10/19): puppet-3.8.7-1.el6.noarch.rpm                                                                                                                                                                                | 1.6 MB     00:00     
(11/19): ruby-1.8.7.374-4.el6_6.x86_64.rpm                                                                                                                                                                            | 538 kB     00:00     
(12/19): ruby-augeas-0.4.1-3.el6.x86_64.rpm                                                                                                                                                                           |  21 kB     00:00     
(13/19): ruby-irb-1.8.7.374-4.el6_6.x86_64.rpm                                                                                                                                                                        | 317 kB     00:00     
(14/19): ruby-libs-1.8.7.374-4.el6_6.x86_64.rpm                                                                                                                                                                       | 1.7 MB     00:01     
(15/19): ruby-rdoc-1.8.7.374-4.el6_6.x86_64.rpm                                                                                                                                                                       | 380 kB     00:00     
(16/19): ruby-shadow-2.2.0-2.el6.x86_64.rpm                                                                                                                                                                           |  13 kB     00:00     
(17/19): rubygem-json-1.5.5-3.el6.x86_64.rpm                                                                                                                                                                          | 763 kB     00:00     
(18/19): rubygems-1.3.7-5.el6.noarch.rpm                                                                                                                                                                              | 206 kB     00:00     
(19/19): virt-what-1.11-1.2.el6.x86_64.rpm                                                                                                                                                                            |  23 kB     00:00     
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Total                                                                                                                                                                                                        432 kB/s | 6.6 MB     00:15     
warning: rpmts_HdrFromFdno: Header V4 RSA/SHA512 Signature, key ID 4bd6ec30: NOKEY
Retrieving key from file:///etc/pki/rpm-gpg/RPM-GPG-KEY-puppetlabs
Importing GPG key 0x4BD6EC30:
 Userid : Puppet Labs Release Key (Puppet Labs Release Key) <info@puppetlabs.com>
 Package: puppetlabs-release-22.0-2.noarch (installed)
 From   : /etc/pki/rpm-gpg/RPM-GPG-KEY-puppetlabs
Is this ok [y/N]: y
Retrieving key from file:///etc/pki/rpm-gpg/RPM-GPG-KEY-puppet
Importing GPG key 0xEF8D349F:
 Userid : Puppet, Inc. Release Key (Puppet, Inc. Release Key) <release@puppet.com>
 Package: puppetlabs-release-22.0-2.noarch (installed)
 From   : /etc/pki/rpm-gpg/RPM-GPG-KEY-puppet
Is this ok [y/N]: y
Running rpm_check_debug
Running Transaction Test
Transaction Test Succeeded
Running Transaction
Warning: RPMDB altered outside of yum.
  Updating   : libselinux-2.0.94-7.el6.x86_64                                                                                                                                                                                           1/22 
  Installing : libselinux-ruby-2.0.94-7.el6.x86_64                                                                                                                                                                                      2/22 
  Updating   : libselinux-utils-2.0.94-7.el6.x86_64                                                                                                                                                                                     3/22 
  Installing : augeas-libs-1.0.0-10.el6.x86_64                                                                                                                                                                                          4/22 
  Installing : compat-readline5-5.2-17.1.el6.x86_64                                                                                                                                                                                     5/22 
  Installing : ruby-libs-1.8.7.374-4.el6_6.x86_64                                                                                                                                                                                       6/22 
  Installing : ruby-1.8.7.374-4.el6_6.x86_64                                                                                                                                                                                            7/22 
  Installing : 1:ruby-shadow-2.2.0-2.el6.x86_64                                                                                                                                                                                         8/22 
  Installing : ruby-irb-1.8.7.374-4.el6_6.x86_64                                                                                                                                                                                        9/22 
  Installing : ruby-rdoc-1.8.7.374-4.el6_6.x86_64                                                                                                                                                                                      10/22 
  Installing : rubygems-1.3.7-5.el6.noarch                                                                                                                                                                                             11/22 
  Installing : rubygem-json-1.5.5-3.el6.x86_64                                                                                                                                                                                         12/22 
  Installing : hiera-1.3.4-1.el6.noarch                                                                                                                                                                                                13/22 
  Installing : ruby-augeas-0.4.1-3.el6.x86_64                                                                                                                                                                                          14/22 
  Installing : virt-what-1.11-1.2.el6.x86_64                                                                                                                                                                                           15/22 
  Installing : pciutils-3.1.10-4.el6.x86_64                                                                                                                                                                                            16/22 
  Installing : 1:facter-2.4.6-1.el6.x86_64                                                                                                                                                                                             17/22 
  Installing : puppet-3.8.7-1.el6.noarch                                                                                                                                                                                               18/22 
  Updating   : libselinux-python-2.0.94-7.el6.x86_64                                                                                                                                                                                   19/22 
  Cleanup    : libselinux-utils-2.0.94-5.8.el6.x86_64                                                                                                                                                                                  20/22 
  Cleanup    : libselinux-python-2.0.94-5.8.el6.x86_64                                                                                                                                                                                 21/22 
  Cleanup    : libselinux-2.0.94-5.8.el6.x86_64                                                                                                                                                                                        22/22 
  Verifying  : ruby-rdoc-1.8.7.374-4.el6_6.x86_64                                                                                                                                                                                       1/22 
  Verifying  : 1:ruby-shadow-2.2.0-2.el6.x86_64                                                                                                                                                                                         2/22 
  Verifying  : pciutils-3.1.10-4.el6.x86_64                                                                                                                                                                                             3/22 
  Verifying  : libselinux-ruby-2.0.94-7.el6.x86_64                                                                                                                                                                                      4/22 
  Verifying  : ruby-augeas-0.4.1-3.el6.x86_64                                                                                                                                                                                           5/22 
  Verifying  : virt-what-1.11-1.2.el6.x86_64                                                                                                                                                                                            6/22 
  Verifying  : compat-readline5-5.2-17.1.el6.x86_64                                                                                                                                                                                     7/22 
  Verifying  : rubygem-json-1.5.5-3.el6.x86_64                                                                                                                                                                                          8/22 
  Verifying  : rubygems-1.3.7-5.el6.noarch                                                                                                                                                                                              9/22 
  Verifying  : puppet-3.8.7-1.el6.noarch                                                                                                                                                                                               10/22 
  Verifying  : ruby-libs-1.8.7.374-4.el6_6.x86_64                                                                                                                                                                                      11/22 
  Verifying  : ruby-irb-1.8.7.374-4.el6_6.x86_64                                                                                                                                                                                       12/22 
  Verifying  : libselinux-python-2.0.94-7.el6.x86_64                                                                                                                                                                                   13/22 
  Verifying  : libselinux-utils-2.0.94-7.el6.x86_64                                                                                                                                                                                    14/22 
  Verifying  : 1:facter-2.4.6-1.el6.x86_64                                                                                                                                                                                             15/22 
  Verifying  : ruby-1.8.7.374-4.el6_6.x86_64                                                                                                                                                                                           16/22 
  Verifying  : libselinux-2.0.94-7.el6.x86_64                                                                                                                                                                                          17/22 
  Verifying  : hiera-1.3.4-1.el6.noarch                                                                                                                                                                                                18/22 
  Verifying  : augeas-libs-1.0.0-10.el6.x86_64                                                                                                                                                                                         19/22 
  Verifying  : libselinux-utils-2.0.94-5.8.el6.x86_64                                                                                                                                                                                  20/22 
  Verifying  : libselinux-2.0.94-5.8.el6.x86_64                                                                                                                                                                                        21/22 
  Verifying  : libselinux-python-2.0.94-5.8.el6.x86_64                                                                                                                                                                                 22/22 

Installed:
  puppet.noarch 0:3.8.7-1.el6                                                                                                                                                                                                                

Dependency Installed:
  augeas-libs.x86_64 0:1.0.0-10.el6    compat-readline5.x86_64 0:5.2-17.1.el6    facter.x86_64 1:2.4.6-1.el6            hiera.noarch 0:1.3.4-1.el6              libselinux-ruby.x86_64 0:2.0.94-7.el6    pciutils.x86_64 0:3.1.10-4.el6     
  ruby.x86_64 0:1.8.7.374-4.el6_6      ruby-augeas.x86_64 0:0.4.1-3.el6          ruby-irb.x86_64 0:1.8.7.374-4.el6_6    ruby-libs.x86_64 0:1.8.7.374-4.el6_6    ruby-rdoc.x86_64 0:1.8.7.374-4.el6_6     ruby-shadow.x86_64 1:2.2.0-2.el6   
  rubygem-json.x86_64 0:1.5.5-3.el6    rubygems.noarch 0:1.3.7-5.el6             virt-what.x86_64 0:1.11-1.2.el6       

Dependency Updated:
  libselinux.x86_64 0:2.0.94-7.el6                                          libselinux-python.x86_64 0:2.0.94-7.el6                                          libselinux-utils.x86_64 0:2.0.94-7.el6                                         

Complete!
```

When first installing Puppet on a host, I'm always interesed in inspecting the local host facts. Facts are key / value pairs Puppet exposes to the Puppet master or Agent, which can be used to take decisions on what need to be applied on the system in question. These facts are also inserted into the PuppetDB, which normally is present in a Puppet Enterprise environment and can be queried to learn more about certain hosts.

The way you inspect these facts is by using a commandline tool called facter.

```
[root@soa-training ~]# facter
architecture => x86_64
augeasversion => 1.0.0
bios_release_date => 12/01/2006
bios_vendor => innotek GmbH
bios_version => VirtualBox
blockdevice_sda_model => VBOX HARDDISK
blockdevice_sda_size => 26843545600
blockdevice_sda_vendor => ATA
blockdevice_sdb_model => VBOX HARDDISK
blockdevice_sdb_size => 26843545600
blockdevice_sdb_vendor => ATA
blockdevice_sdc_model => VBOX HARDDISK
blockdevice_sdc_size => 34359738368
blockdevice_sdc_vendor => ATA
blockdevice_sr0_model => CD-ROM
blockdevice_sr0_size => 1073741312
blockdevice_sr0_vendor => VBOX
blockdevices => sda,sdb,sdc,sr0
boardmanufacturer => Oracle Corporation
boardproductname => VirtualBox
boardserialnumber => 0
domain => home
facterversion => 2.4.6
filesystems => ext4,iso9660
fqdn => soa-training.home
gid => root
hardwareisa => x86_64
hardwaremodel => x86_64
hostname => soa-training
id => root
interfaces => eth4,lo
ipaddress => 10.0.2.15
ipaddress_eth4 => 10.0.2.15
ipaddress_lo => 127.0.0.1
is_virtual => true
kernel => Linux
kernelmajversion => 3.8
kernelrelease => 3.8.13-44.el6uek.x86_64
kernelversion => 3.8.13
lsbdistcodename => n/a
lsbdistdescription => Oracle Linux Server release 6.7
lsbdistid => OracleServer
lsbdistrelease => 6.7
lsbmajdistrelease => 6
lsbminordistrelease => 7
lsbrelease => :base-4.0-amd64:base-4.0-noarch:core-4.0-amd64:core-4.0-noarch:graphics-4.0-amd64:graphics-4.0-noarch:printing-4.0-amd64:printing-4.0-noarch
macaddress => 08:00:27:7D:1B:86
macaddress_eth4 => 08:00:27:7D:1B:86
manufacturer => innotek GmbH
memoryfree => 4.15 GB
memoryfree_mb => 4245.78
memorysize => 7.80 GB
memorysize_mb => 7988.01
mtu_eth4 => 1500
mtu_lo => 65536
netmask => 255.255.255.0
netmask_eth4 => 255.255.255.0
netmask_lo => 255.0.0.0
network_eth4 => 10.0.2.0
network_lo => 127.0.0.0
operatingsystem => OracleLinux
operatingsystemmajrelease => 6
operatingsystemrelease => 6.7
os => {"name"=>"OracleLinux", "lsb"=>{"majdistrelease"=>"6", "distrelease"=>"6.7", "minordistrelease"=>"7", "distid"=>"OracleServer", "distdescription"=>"Oracle Linux Server release 6.7", "distcodename"=>"n/a", "release"=>":base-4.0-amd64:base-4.0-noarch:core-4.0-amd64:core-4.0-noarch:graphics-4.0-amd64:graphics-4.0-noarch:printing-4.0-amd64:printing-4.0-noarch"}, "release"=>{"major"=>"6", "minor"=>"7", "full"=>"6.7"}, "family"=>"RedHat"}
osfamily => RedHat
partitions => {"sdb1"=>{"filesystem"=>"ext4", "uuid"=>"104d0e7f-e4ff-4ebb-9282-6bf59a5dd1a9", "size"=>"52426752", "mount"=>"/u01"}, "sda1"=>{"filesystem"=>"ext4", "uuid"=>"10e949d3-7099-4e7e-a89a-398f10d083e3", "size"=>"1024000", "mount"=>"/boot"}, "sda2"=>{"filesystem"=>"LVM2_member", "size"=>"51402752"}}
path => /usr/lib64/qt-3.3/bin:/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin
physicalprocessorcount => 1
processor0 => Intel(R) Core(TM) i5-4210M CPU @ 2.60GHz
processor1 => Intel(R) Core(TM) i5-4210M CPU @ 2.60GHz
processorcount => 2
processors => {"models"=>["Intel(R) Core(TM) i5-4210M CPU @ 2.60GHz", "Intel(R) Core(TM) i5-4210M CPU @ 2.60GHz"], "count"=>2, "physicalcount"=>1}
productname => VirtualBox
ps => ps -ef
puppetversion => 3.8.7
rubyplatform => x86_64-linux
rubysitedir => /usr/lib/ruby/site_ruby/1.8
rubyversion => 1.8.7
selinux => true
selinux_config_mode => enforcing
selinux_config_policy => targeted
selinux_current_mode => enforcing
selinux_enforced => true
selinux_policyversion => 28
serialnumber => 0
sshdsakey => AAAAB3NzaC1kc3MAAACBAKZRL6z7cWPGJoD2cnMCrRTDbis4RiNZrZe3PKs/sNUvDqWNjBksNDW49SJ1xTtbCpwKrODG4qN6zXtY/eJGT+kwBf+edcNvWQqzwo7fPbEMVIkX5tRyAzZAu7YvWrrhxHuC6oSSa0rSWyHExlxgP4aYKKF9LbB/TAOzRUSQY++xAAAAFQD2QJq0WovnGViFYIrxpYPFwOoMkwAAAIBPvM6kN5RbdOetS1qWVk0DG67C6rhDNEWkR2/Yll8TA6o/aQRVIfykmo5DLvyjgTzGeiPpPLpghTWLjEgtBjxO7dHMRhnedDo8PhG2AQeWUDrU/4ipdVwQUPCxOXJdJrAIjnPJqVYkpDEmoWvr5l6hPQSBraKmfUh8wGGwupXQgwAAAIBqlmC57XE26a78zuJjZksXuPcDjSv/PhruTBhtyKGZnNHRYeTZs1fU7tNRTntaF0USdeJq+yIm3BYkBh3cr3gVdC5R287gmc1LYmGI47srcXwq69QVwaO9nLY//uOID+d8E8+aw97sXo1Pf6oGq87Zy+EZqp0RF62KAM6VmFl6MA==
sshfp_dsa => SSHFP 2 1 5d30663a5341205d264e6f137057943367ef1535
SSHFP 2 2 8596647f5ac7e96306419fb61a48be5847256c81c5b9585e8efa67a58a922853
sshfp_rsa => SSHFP 1 1 c38d3cbd68a1b45935406ac65dbf16fce4851529
SSHFP 1 2 5ee3dd20d281a52493d8a191299c0dd855f7ab85aa2ee9be0d6e27de0e1f3cfc
sshrsakey => AAAAB3NzaC1yc2EAAAABIwAAAQEA0mehVvIWW021Obm9Mo7qycPlzMFdAju1piRoaEkCLIUqToLesxkUByzcAvwF8p9EsZ5GDjH4rpS4fZsfUl3JejGTpzb1eHEl5M9P5nmNmCYZSR3wtgtyo56zR0r5AeAa/9RIM6iGkU3mGrunzp1cfLmZmK+SaTE9OmSdzVHBnWzilkVWRZqTzYtptcYbWLlbjCSlCuTg/c8rVn9qq/9jte/qwtPYQYKdc3mjqBvLBNej02r3T8C/uMhN/GxFdUahZLjkLqRnA8c/w3kbMuhBGsxWXO3S6NYRgSPughQhU3hDlHTtdvMjhXOPaidjc91vnE6pyyfNDRZhwDad+2g2vw==
swapfree => 6.00 GB
swapfree_mb => 6144.00
swapsize => 6.00 GB
swapsize_mb => 6144.00
system_uptime => {"seconds"=>2538, "uptime"=>"0:42 hours", "days"=>0, "hours"=>0}
timezone => PST
type => Other
uniqueid => 007f0100
uptime => 0:42 hours
uptime_days => 0
uptime_hours => 0
uptime_seconds => 2538
uuid => E13F417C-AE61-4632-ABAB-594A87BA82D6
virtual => virtualbox
[root@soa-training ~]# 
```

The reason I installed Puppet in a preconfigured WebLogic boss is because I want to inspect Weblogic data with Puppet. For this, we need external modules we install in a minute, but Puppet has a lot of build in types as well. As a sneak peak, we inspect some file resources below.

```
[root@soa-training ~]# puppet resource file /etc/passwd
file { '/etc/passwd':
  ensure   => 'file',
  content  => '{md5}943982ae9c22abaeaeeed023983adddd',
  ctime    => 'Mon Mar 06 12:13:24 -0800 2017',
  group    => '0',
  mode     => '644',
  mtime    => 'Mon Mar 06 12:13:24 -0800 2017',
  owner    => '0',
  selrange => 's0',
  selrole  => 'object_r',
  seltype  => 'etc_t',
  seluser  => 'system_u',
  type     => 'file',
}
[root@soa-training ~]# puppet resource file /etc
file { '/etc':
  ensure   => 'directory',
  ctime    => 'Mon Mar 06 12:13:39 -0800 2017',
  group    => '0',
  mode     => '755',
  mtime    => 'Mon Mar 06 12:13:39 -0800 2017',
  owner    => '0',
  selrange => 's0',
  selrole  => 'object_r',
  seltype  => 'etc_t',
  seluser  => 'system_u',
  type     => 'directory',
}
[root@soa-training ~]# puppet resource file 
Error: Could not run: Listing all file instances is not supported.  Please specify a file or directory, e.g. puppet resource file /etc
```

As you can see, we inspected the /etc/passwd file, the /etc directory, and tried to do a puppet resource file on all the files Puppet could find. This last command would have shown us thousands of files which is not desirable.

### Step 2: Configure Puppet to be able to connect to the WebLogic domain

Puppet is not shipped with the modules needed to inspect WebLogic out of the box. In order to be able to see these resources, we need to install [the orawls module]( https://github.com/biemond/biemond-orawls) written by [Edwin Biemond](https://twitter.com/biemond) which is the most complete I know of.

```
[root@soa-training Desktop]# puppet module install biemond-orawls
Notice: Preparing to install into /home/oracle/.puppetlabs/etc/code/modules ...
Notice: Created target directory /home/oracle/.puppetlabs/etc/code/modules
Notice: Downloading from https://forgeapi.puppet.com ...
Notice: Installing -- do not interrupt ...
/home/oracle/.puppetlabs/etc/code/modules
└─┬ biemond-orawls (v2.0.3)
  ├── adrien-filemapper (v1.1.3)
    ├── fiddyspence-sleep (v1.2.0)
      ├── hajee-easy_type (v0.15.5)
        ├── puppetlabs-stdlib (v4.15.0)
          └── reidmv-yamlfile (v0.2.0)
```

Although this blogpost is not about writing Puppet code, we need to do it anyway. orawls needs to know how to connect to WebLogic. For this, it stores a YAML file on the system containing connection details in a file which is readable by the root user only.

The manifest required for the demo box looks like this:
```
wls_setting { 'default':
  user                         => 'oracle',
  weblogic_home_dir            => '/u01/fmw/soa/wlserver',
  connect_url                  => "t3://localhost:7001",
  weblogic_user                => 'weblogic',
  weblogic_password            => 'welcome1',
  use_default_value_when_empty => true
}
```

Apply the manifest using puppet apply:
```
[root@soa-training Desktop]# puppet apply soaenv.pp 
Notice: Compiled catalog for soa-training.home in environment production in 0.09 seconds
Notice: /Stage[main]/Main/Wls_setting[default]/user: defined 'user' as 'oracle'
Notice: /Stage[main]/Main/Wls_setting[default]/weblogic_home_dir: defined 'weblogic_home_dir' as '/u01/fmw/soa/wlserver'
Notice: /Stage[main]/Main/Wls_setting[default]/weblogic_user: defined 'weblogic_user' as 'weblogic'
Notice: /Stage[main]/Main/Wls_setting[default]/connect_url: defined 'connect_url' as 't3://localhost:7001'
Notice: /Stage[main]/Main/Wls_setting[default]/weblogic_password: created password
Notice: /Stage[main]/Main/Wls_setting[default]/debug_module: defined 'debug_module' as 'false'
Notice: /Stage[main]/Main/Wls_setting[default]/archive_path: defined 'archive_path' as '/tmp/orawls-archive'
Notice: /Stage[main]/Main/Wls_setting[default]/custom_trust: defined 'custom_trust' as 'false'
Notice: /Stage[main]/Main/Wls_setting[default]/use_default_value_when_empty: defined 'use_default_value_when_empty' as 'true'
Notice: Finished catalog run in 0.10 seconds
```

### Step 3: Inspect resources

We're finally done preparing and are now able to look at our beloved WebLogic resources. I've printed out some samples below.

```
[root@soa-training ~]# puppet resource wls_jms_topic
wls_jms_topic { 'default/BAMJMSSystemResource:oracle.beam.cqs.activedata':
  ensure            => 'present',
  consumptionpaused => '0',
  defaulttargeting  => '0',
  deliverymode      => 'No-Delivery',
  distributed       => '0',
  expirationpolicy  => 'Discard',
  insertionpaused   => '0',
  jndiname          => 'topic/oracle.beam.cqs.activedata',
  productionpaused  => '0',
  redeliverydelay   => '-1',
  redeliverylimit   => '-1',
  subdeployment     => 'BAMJMSSubDeployment',
  timetodeliver     => '-1',
  timetolive        => '-1',
}
wls_jms_topic { 'default/BAMJMSSystemResource:oracle.beam.persistence.activedata':
  ensure            => 'present',
  consumptionpaused => '0',
  defaulttargeting  => '0',
  deliverymode      => 'No-Delivery',
  distributed       => '0',
  expirationpolicy  => 'Discard',
  insertionpaused   => '0',
  jndiname          => 'topic/oracle.beam.server.event.dataobject',
  productionpaused  => '0',
  redeliverydelay   => '-1',
  redeliverylimit   => '-1',
  subdeployment     => 'BAMJMSSubDeployment',
  timetodeliver     => '-1',
  timetolive        => '-1',
}
```

```
[root@soa-training Desktop]# puppet resource wls_domain
wls_domain { 'default/compact_domain':
  ensure                                            => 'present',
  credential                                        => '<encrypted credential>',
  exalogicoptimizationsenabled                      => '0',
  jmx_platform_mbean_server_enabled                 => '0',
  jmx_platform_mbean_server_used                    => '1',
  jpa_default_provider                              => 'org.eclipse.persistence.jpa.PersistenceProvider',
  jta_max_transactions                              => '10000',
  jta_transaction_timeout                           => '30',
  log_date_pattern                                  => 'MMM d, yyyy h:mm:ss a z',
  log_domain_log_broadcast_severity                 => 'Notice',
  log_file_min_size                                 => '500',
  log_filecount                                     => '7',
  log_filename                                      => 'logs/compact_domain.log',
  log_number_of_files_limited                       => '1',
  log_rotate_logon_startup                          => '1',
  log_rotationtype                                  => 'bySize',
  security_crossdomain                              => '0',
  setconfigurationaudittype                         => 'none',
  setinternalappdeploymentondemandenable            => '0',
  web_app_container_show_archived_real_path_enabled => '0',
}
```

```
[root@soa-training Desktop]# puppet resource wls_server
wls_server { 'default/AdminServer':
  ensure                           => 'present',
  auto_restart                     => '1',
  autokillwfail                    => '0',
  client_certificate_enforced      => '0',
  custom_identity                  => '0',
  frontendhttpport                 => '0',
  frontendhttpsport                => '0',
  jsseenabled                      => '1',
  listenport                       => '7001',
  listenportenabled                => '1',
  log_datasource_filename          => 'logs/datasource.log',
  log_date_pattern                 => 'MMM d, yyyy h:mm:ss a z',
  log_file_min_size                => '500',
  log_filecount                    => '7',
  log_http_file_count              => '7',
  log_http_filename                => 'logs/access.log',
  log_http_format                  => 'date time cs-method ctx-ecid ctx-rid cs-uri sc-status bytes',
  log_http_format_type             => 'extended',
  log_http_number_of_files_limited => '1',
  log_log_file_severity            => 'Trace',
  log_number_of_files_limited      => '1',
  log_redirect_stderr_to_server    => '0',
  log_redirect_stdout_to_server    => '0',
  log_rotate_logon_startup         => '1',
  log_rotationtype                 => 'bySize',
  log_stdout_severity              => 'Notice',
  logfilename                      => 'logs/AdminServer.log',
  logintimeout                     => '5000',
  max_message_size                 => '10000000',
  restart_max                      => '2',
  server_parameters                => 'None',
  sslenabled                       => '0',
  sslhostnameverificationignored   => '0',
  sslhostnameverifier              => 'None',
  ssllistenport                    => '7002',
  tunnelingenabled                 => '0',
  two_way_ssl                      => '0',
  useservercerts                   => '0',
  weblogic_plugin_enabled          => '0',
}
```

The fun part is that this is valid Puppet code! Copy the output from puppet resource, paste it in a file and change what you want to change. Then do a 'puppet apply FILENAME.pp' and the changes should populate. This way you can start out small with managing WebLogic with Puppet and discover the available parameters in a non destructive way.
