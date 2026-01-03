---
date: "2025-08-23"
title: Running Caddy and Anubis over multiple domains to deny AI Bots
tags: ["ai", "ethics", "hosting"]
author: Me
showToc: false
TocOpen: false
draft: false
hidemeta: false
comments: false
disableHLJS: true  # to disable highlightjs
disableShare: false
searchHidden: true
---

A few weeks ago I wanted to write up a silly thing for my food blog [www.omnomfrickinnom.com](https://www.omnomfrickinnom.com) (it's fun to say, try it) and I paused and didn't write it.  I didn't want some unethical scraping bot to come use my content, without my permiision.  Consent is important, and most AI companies are not respectful of my wishes.

So, I set about working out how to protect my website with [Anubis](https://anubis.techaro.lol), a great tool which uses computational challenges to stop AI bots in their tracks.

The problem: I use a single VM to host all my sites, and Anubis isn't the easiest to wire up to [Caddy](https://caddyserver.com) as my webserver.  Most of the examples I could find had examples for protecting a single domain/site with Anubis, but I have 17.  I found [this excellent post](https://www.corgijan.dev/2025/05/10/caddy-anubis.html) but I ended up needing to hack about quite a bit to get it up and running.

## The plan

Use two different Caddy instances, one either side of Anubis, and rely on `X-Forwarded-Host` headers to unpack the final destination.  This is all running on my crappy Ubuntu host.

![Big diagram including The Internet Cloud](/images/caddy-anubis-caddy.png)

I'll refer to `public-caddy` as the one facing the internet and `private-caddy` for the one that is used internally.

## Running two copies of Caddy

The first problem I needed to solve was how to run 2 different instances of Caddy.  I chose the quick and dirty method of cloning the caddy service file in `/usr/lib/systemd/system` and tweaking them to load specific Caddy config files.  There are neater ways to do this by injecting variables, but I wanted a weekend.

```
cp /usr/lib/systemd/system/caddy.service /usr/lib/systemd/system/caddy-public.service 
cp /usr/lib/systemd/system/caddy.service /usr/lib/systemd/system/caddy-private.service
```

Then switch up some lines to include "public" and "private"

```
[Unit]
Description=Caddy-Public

[Service]
ExecStart=/usr/bin/caddy run --environ --config /etc/caddy/Caddyfile-Public
ExecReload=/usr/bin/caddy reload --config /etc/caddy/Caddyfile-Public --force
```

This unlocks launching independant instances of Caddy like this (using private as an example)
```
systemctl restart caddy-private.service
```

## `public-caddy` config

The public version of Caddy is there to do all the SSL/HTTPS automagic that Caddy is so good for, and then to hand off all the traffic to Anubis.   This leads to some reasonably simple if irritatingly verbose config.

I look forward to hating this next time I buy a new domain.

```
www.domain1.com www.domain2.com www.domain3.com {
reverse_proxy localhost:8923
}

```

## Anubis config

Anubis docs are pretty verbose and I struggled a bit.  This is what I ended up with in `/etc/anubis/default`

Key bits:
* BIND port matches the one that `public-caddy` is forwarding onto
* TARGET port matches the one that `private-caddy` is bound onto
* REDIRECT_DOMAINS macthes the list of domains in `public-caddy` but with commas

```

BIND=:8923
DIFFICULTY=4
METRICS_BIND=:9090
SERVE_ROBOTS_TXT="true"
TARGET="http://localhost:7000"
POLICY_FNAME="/etc/anubis/bot.yaml"
REDIRECT_DOMAINS="www.domain1.com,www.domain2.com,www.domain3.com,"
OG_PASSTHROUG="true"
OG_EXPIRY_TIME="24h"

```

You can check that Anubis is up and running by poking it with `nc localhost 8923`



## `private-caddy` config

My private Caddy config is based on my rather verbose exiting config, but with tweaks to set up...

* Not doing and of the HTTPS automagic
* Using the `X-Forwarded-Host` header to route to the right file_server backend

I use the very simple file_server backend for Caddy, I'm pretty sure that this would work with more complex backends.   


```
{
        auto_https off
}

:7000 {
    @wwwdomain1com {
        header X-Forwarded-Host www.domain1.com
    }

    handle @wwwdomain1com {
    root * /var/www/wwwdomain1com/
    file_server
        encode gzip
    }

    @wwwdomain2com {
        header X-Forwarded-Host www.domain2.com
    }

    handle @wwwdomain2com {
    root * /var/www/wwwdomain2com/
    file_server
        encode gzip
    }

    @wwwdomain3com {
        header X-Forwarded-Host www.domain3.com
    }

    handle @wwwdomain3com {
    root * /var/www/wwwdomain3com/
    file_server
        encode gzip
    }
}

```

## The result

I am once again good to write up silly food past, safe in the knowledge that my content is harder to scrape.  I've no idea if it'll affect my search engine rankings, and frankly my dear, I don't give a damn.  OpenAI, Grok and all these others can go fuck themselves. 
