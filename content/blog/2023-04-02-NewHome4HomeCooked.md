+++
title = "A new home for Homecooked.nl"
date = 2023-04-02:00:00+00:00
tags = []
categories = []
+++

I had an old Ubuntu VPS running a bunch of web tools for ages already. It needed updating as Ubuntu 18.04 will be deprecated this month. I thought long and hard on how I wanted to tackle this. There were some options...

- Kubernetes (with k3s)
- Nomad (To get a bit familiar with this)
- Apps on fly.io

It all felt like a bunch of mostly overengineered work to me...

## What did I end up with?

Ubuntu 22.04, with a bunch of differences from the old setup

- Everything is in Docker
- [Watchtower](https://containrrr.dev/watchtower/) automatically updates all containers
- Postgres running as a non-docker container for apps needing state, I had to tweak some things:
  - postgres.conf to listen on all (internal) ips
  - pg_hba.conf for firewall from Docker to host
- tt-rss, my trusty rss reader running as a docker-compose instead of my old git based installation following master of the git repo
- Some other apps, also running as Docker containers

It took me 2-3 hours to migrate everything, clean up / backup old stuff on the old VM and do some cleanup.

Another choire off the todo list.
