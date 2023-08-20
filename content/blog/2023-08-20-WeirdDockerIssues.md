+++
title = "Weird docker issues"
date = 2023-08-20T00:00:00+00:00
tags = []
categories = []
+++

Weird docker issues caused by an experienced DevOps guy who does not pay too much attention to the configuration of his own setup at home, apparantly...

## So what happened

This site has been offline a lot. And it was only fixed when I noticed it being offline because there is no monitoring setup for this yet. "Incidents", in quotes because this is hardly a production thing, were always happening like this:

- Everything was running fine
- Then some (NOT ALL) containers were in status stopped, no errors in the logs of the containers or in the logs of the docker service
- SysAdminGuy (Me) logged on to the server in a hurry and started the stopped container, not spending time on the RCA

## RCA

Today I was done with it and did a root cause analysis. I feel a bit silly about it, but I did not setup a restart policy for the containers. When the OS is autopatched, the system occasionally reboots afterwards and the containers were not started because of this.

This was fixed using the following command:

```
docker update --restart unless-stopped homecooked
```

Another day another issue resolved.

## Next

I obviously need monitoring, and I also want to spent some love on my personal infrastructure, exploring how I think things need to be done outside of work context. I hope to blog about that a bit more in the future.
