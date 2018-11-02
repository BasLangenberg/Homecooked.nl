+++
title = "Fix a Crashing WebLogic Instance"
date = 2018-10-30T12:59:54+01:00
tags = []
categories = []
+++

Recently, I had some very strange behavior at a customer. The AdminServer of a freshly create domain refused to start.

It was very strange since all the prerequisites were installed and the jvm version was supported. We tested a bunch of things:

* Downgrade Java to the version in the prebuild virtualbox image provided by Oracle;
* Play with some ulimit settings for user Oracle;
* Make oracle user able to dump it's core;
* Try to actually get debug symbols for the core dump;

One of the things I saw once during debugging is problems with becoming a different user on the OS within the JVM. In the end, this explains the solution provided.

Behavior noticed:

```
Enter username to boot WebLogic server:weblogic
Enter password to boot WebLogic server:
<Oct 3, 2018 4:53:56 PM CEST> <Notice> <WebLogicServer> <BEA-000365> <Server state changed to STARTING.>
#
# A fatal error has been detected by the Java Runtime Environment:
#
#  SIGSEGV (0xb) at pc=0x00007f113fdd2ea9, pid=4688, tid=0x00007f1108603700
#
# JRE version: Java(TM) SE Runtime Environment (8.0_144-b01) (build 1.8.0_144-b01)
# Java VM: Java HotSpot(TM) 64-Bit Server VM (25.144-b01 mixed mode linux-amd64 compressed oops)
# Problematic frame:
# C  [libc.so.6+0x4cea9]  _IO_vfprintf+0x4a79
#
# Failed to write core dump. Core dumps have been disabled. To enable core dumping, try "ulimit -c unlimited" before starting Java again
#
# An error report file with more information is saved as:
# /app/oracle/config/aserver/domains/dsoa01/hs_err_pid4688.log
#
# If you would like to submit a bug report, please visit:
#   http://bugreport.java.com/bugreport/crash.jsp
# The crash happened outside the Java Virtual Machine in native code.
# See problematic frame for where to report the bug.
#
./startWebLogic.sh: line 205:  4688 Aborted                 (core dumped) ${JAVA_HOME}/bin/java ${JAVA_VM} ${MEM_ARGS} ${LAUNCH_ARGS} -Dweblogic.Name=${SERVER_NAME} -Djava.security.policy=${WLS_POLICY_FILE} ${JAVA_OPTIONS} ${PROXY_SETTINGS} ${SERVER_CLASS}
Stopping Derby server...
Derby server stopped.
```

This behavior was not found in a virtual machine I quickly created so I suspect something was going on with the machine provided by the infrastructure team. While debugging, I raised an SR with Oracle.

Oracle was super helpfull and it only took them a few days to point me to the correct Document on Oracle support which I *Obviously* missed.

To fix this, make sure the Unix Machine section looks like this in $DOMAIN_HOME/config/config.xml:

```
  <machine xsi:type="unix-machineType">
    <name>dfmw01</name>
    <node-manager>
      <name>dfmw01</name>
      <listen-address>dfmw01.ihc.eu</listen-address>
    </node-manager>
    <post-bind-uid-enabled>true</post-bind-uid-enabled>
    <post-bind-uid>oracle</post-bind-uid>
    <post-bind-gid-enabled>true</post-bind-gid-enabled>
    <post-bind-gid>dba</post-bind-gid>
  </machine>
```

After which the JVM will start correctly.