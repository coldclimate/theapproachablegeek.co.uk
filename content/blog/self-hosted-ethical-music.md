---
date: "2026-02-08"
title: Self-Hosted ethical music setup
tags: ["music", "ethics", "hosting", "selfhosting"]
author: Me
showToc: false
TocOpen: false
draft: false
hidemeta: false
comments: false
disableHLJS: true # to disable highlightjs
disableShare: false
disableHLJS: false
searchHidden: true
---


Last year, when I realised [Spotify had donated the inagustation of President Fart](https://community.spotify.com/t5/Social-Random/Why-the-actual-F-is-Spotify-paying-for-Trump-s-inauguration/td-p/6665345), I cancelled my membership.  Actually, I asked to be taken off our family membership, and thus it was dropped to a single user account.

Anyway, at that point I realised quite what a crappy deal for everybody that music streaming business was, paying artists absolutely pennies, investing in arms companies, running adverts for facist dictatorship, using AI to generate "music" where they need to pay literally nothing to anybody despite having trained on artists works without permission, and recently laying off a lot of their tech staff.  

They are dead to me, but I still want to listen to music and support artists, so I needed to do something.

Thus, I have setup a quick and dirty streaming platform that does what I need it to do...

* Indexes my music collection
* Makes it accessable inside and outside the house
* Is backed up.


Where does my music come from?

1. I ripped all my CD collection.   It took a while, and sorting out the metadata was a massive pain in the arse, but [Music Brainz Picsrd](https://picard.musicbrainz.org) did a great job
2. I've started buying stuff though BandCamp, especially [On BandCamp Friday](https://isitbandcampfriday.com)
3. I still use and pay for [MixCloud](https://www.mixcloud.com) who I hope do the right thing.  All my conversations with their engineers many years ago give me hope they do.
4. At some point I'll dig into [qobuz](https://www.qobuz.com/gb-en/discover) and see if they are actually as good as people seem to think

## The setup

In the house I now have...

* 1 new (secondhand) laptop - machine1
* 1 old (secondhand) laptop - machine2 (an old MacBook Pro that currently powers SkyCam)
* 2 new external 2TB USB drives 

Both laptops are running Ubuntu 24.04.3 LTS (server edition, no need for a GUI).


machine1 is running...

* [Navidrome](https://www.navidrome.org) for streaming music
* [TailScale](https://tailscale.com) for VPNing in from the outside world
* [SyncThing](https://syncthing.net) for keeping the two machines in sync
* Some shonky Bash scripts for backing up to [Upcloud](https://signup.upcloud.com/?promo=NPW276) (referal link, $25 of credit each way)


machine2 is also running SyncThing

I already had an old MacBook Pro 2015 running linux that is setup for powering my SkyCam, so that was a good start.  This machine (machine2) will be my inhouse backup.

To act as my "primary" home server (machine1) I bought a second hand Dell Vostro 15 5501, with an i5 chip, 16GB RAM and an internal 512GB SSD drive from [jamiescomputers](https://www.ebay.co.uk/str/jamiescomputers) on ebay, and to quote them " Jamie’s Computers is a social enterprise. 100% of our proceeds are donated to The Society of St James; Hampshire's largest homelessness charity."

I bought this machine specifically because it is [Ubuntu Certified](https://ubuntu.com/certified/202002-27735).  Whilst most laptops will happily run Linux, I've lost enough time fighting with drivers over the last 20 years that I decided to increase my chances of not loosing a load of weekend to this project.

This machine is the hub of my self-hosting setup.  It's running stuff other than Navidrome, but more on that another day.


## Mounting external disks

Both machines have external drives hanigng off them, and whilst they have an internal battery which happily survive a few hours of power outage (old laptop make great home servers - built in UPS!), it's a pain in the arse when they reboot and the external disk doesn't mount.

So, here's all the steps I used to format the disk and make it mount automatically on boot.

1. Attach the drive
2. `lsblk -f` and looks for the new disk.  Mine was appearing as /dev/sdc1.   Whilst in there I also copied it's 32 character GUID "a682d734-xxx-xxxx-xxxx-44b72d9ded8e"
3. `sudo mkfs -t ext4 /dev/sdc1` to format the disk with ext4
4. `sudo mkdir -p /media/$USER/external` to create somewhere to mount it
5. `sudo chown $USER:$USER /media/$USER`
6. `sudo chown $USER:$USER /media/$USER/external`
7. Added `UUID="a682d734-xxxx-xxxx-xxxx-44b72d9ded8e" /media/[user]/external auto nosuid,nodev,nofail 0 0` to the end of my `/etc/fsab` (replace [user] with the appropriate word)
8. `sudo mount -a` to remount everything in `/etc/fstab`
9. `sudo systemctl daemon-reload` to make it happy
10. `mount` to check that the external disk is actually mounted
11. `cd /media/$USER/external` to move there
12. `touch a` to make sure the disk is writable

At this point I should probably reboot the machine just to check it all mounts properly, but meh, it's Saturday.


## Installing Navidrome

I'm choosing to run everything on machine1 in it's own Docker container.  I don't have to, but it's handy practice.  Under the hood it's actually [Podman](https://podman.io), but again, something for another day.  No k8s or rancher or anything fancy, just Docker Compose.

The docker compose file here is pretty simple, it's mounting a couple of local bits of disk to keep all the data on, rather than inside the ephemeral container.

```
services:
  navidrome:
    image: deluan/navidrome:latest
    user: 1000:1000 # should be owner of volumes
    ports:
      - "4533:4533"
    restart: unless-stopped
      #environment:
      # Optional: put your config options customization here. Examples:
      # ND_LOGLEVEL: debug
    volumes:
      - "/home/[user]/navidrome:/data"
      - "/media/[user]/external/Music/:/music:ro"

```

Replace `[user]` and paths as needed and then run `docker compose up -d` to start the container.

I can hit the IP address for this machine on `http:/192.168.1.xxx:4533` and the Navidrome interface comes up, winning.  Time to leave it to index all that music I shoved onto the drive.

I can now hit this address from any machine in the house on this WiFi network, so that's streaming to my phone sorted, whilst at home.

## Access from the outside world

Here I decided to use an external service, TailScale.  It makes me a little nervous, but it's a risk I can live with, and right now it's free.   TailScale has an Android app too, which is my primary driver - being able to stream music from Navidrome to my phone when driving.

1. I signed up at [tailscale.com](https://tailscale.com) and chose Github as my identity provider.  I dislike that I can't use an email+password+2FA.   Eventually I'll look into how I setup an OIDC provider.
2. I followed [https://tailscale.com/docs/how-to/quickstart](this quickstart guide). Adding the primary linux box as a device invovles pressing some buttons and then running a script they provide as root back on the machine which makes me feel 🤮


I chose not to do anything especially exciting, though I intend at some point to follow [some steps like these](https://hachyderm.io/@aires@tiggi.es/116008967964230612) to mean I don't have to use IP addresses everywhere.  Something for a future weekend.

After installing the Android app on my phone I can now turn on TailScale and then open a browser and head to 100.x.x.x:4533 and magically I'm in Navidrome, and it works everywhere, not just when I'm on the house WiFI.  More winning.

## Intra-house backup
I'd be sad if I lost all my hard rippped MP3s, and I've got another machine running 24/7 in the house, so I decided to stick another cheap USB drive on it, formatted and mounted the same way, and then use SyncThing to keep the two machines in sync (cunning name)

I followed these [steps to install SyncThing onto Ubuntu](https://docs.natenetworks.com/books/03-all-about-ubuntu/page/installing-syncthing-as-a-service-in-ubuntu) and they worked just fine.  I did this on both Linux laptops.

SyncThing has a web based GUI, but it only binds to `localhost:8384` so you can't hit it form other machines direclty unless you open it up (and I didn't want to do that).   These being headless linux machines, there's no GUI for browser to run in, and besides, I didn't want to have to walk upstairs.  However, some 25 year old commands came to the rescue - SSH Port Forwarding.


In 2 different [GhostTTY](https://ghostty.org) tabs on my daily-driver laptop I ran

`ssh user@machine1 -L8382:localhost:8384` and `ssh user@machine2 -L8380:localhost:8384`

This routes traffic from port 8384 on the remoe machines back to ports 8382 and 8380 on the local machine respectively, meaning I can open up a browser and connect to `http://localhost:8380` and see the interface to SyncThing on machine2.

From there it was a matter of using the slightly unintuitive GUI to setup and accept syncing from machine1 and to machine2, choosing the external disks each time.

Note: The first time I did this I goofed and tried syncing 300GB of music to the internal disk of machine2, filling it and breaking SkyCam. Sad times.

## Backing up to The Cloud (in the EU)

I recently dropped all my personal stuff from AWS, choosing an EU based provider that's not affiliated with a billionaire.  I chose Upcloud](https://signup.upcloud.com/?promo=NPW276) because they seemed like sensible folk, and they have an S3 compatable object store for sensible money which saves me learning another set of tools.  Their chat on [mastodon](https://glitchy.upcloud.world/@upcloud) is also a nice mix of shitposting and tech, which gives me faith.

My plan here is to sync from machine1 to a bucket in Upcloud periodically (mostly, when I remember).   I'll move this to something smarter like [BorgBackup](https://www.borgbackup.org) some day for now I'm trying to mitigate loosing all my tunes if something terrible happens to my house.

I setup a new "Object Store" in Upcloud, and then a bucket inside it.   Unlike AWS, Upcloud object buckets do not have to globally unique names, which is nice.  Instead you have to specify endpoints in the tools, as well as bucket names.

Upcloud have some good instructions on [how to wire up the standard AWS CLI to their storage](https://upcloud.com/docs/guides/connecting-to-an-object-storage-instance-s3cmd/) which I followed, and then wrote a little script to sync everything off machine1 up to them.

```
#!/bin/bash
export AWS_CONFIG_FILE=$HOME/awsconfig/config
export AWS_SHARED_CREDENTIALS_FILE=$HOME/awsconfig/credentials
aws s3 sync . s3://music/

```

A little note on this - I didn't put my credencials in the default locations, because recent supply chain attached have started exfiltrating them.  I've no idea if moving them from the default location helpls but 🤷 can't hurt.

Another note: by default the "sync" command doesn't remove anything from the destination, so if I accidentally delete something, it'll still be there.  Eventually this might lead to clutter and choas, but right now, it's fine, because I almost never move or delete stuff.

To do the first sync I ran this script with nohup, so I could close the window.

`nohup ./backup.sh`

In the morning, there was a 500MB log file, telling me that 300GB+ had been pushed up the line to them.  No I just have to remember to run it periodically.


## Adding music

So by this point I've a music server which is serving me tunes inside the house and outside of it, with my pretty extensive collection already there, but what happens when I download new tunes (having paid artists for them)?

Those downloads generally happen on my daily-driver laptop.   I generally check their metadata with Picard and clean it up if needed (I have opinions on artist/track info) and then I shove it across to machine one with the venerable SSH!

`scp -r * user@machine1:/media/user/external/music`

This will probably screw me over one day when I name clashes, but I'll figure that out then, and start using some sort of landing zone + "import and reorganise" setup.

SyncThing does it's job and the music automagically gets copied to machine2, and next time I backup, it'll flow up to Upcloud

##  End Result

* Music I own is streamable anywhere I am
* It's backups up twice
* I'm not supporting billionaires with any of this stack
* Plenty of room for optimasation
* Kept me entertained and doing some sysadmin for a few weekends in total.

It's worth noting the BandCamp have mobile phone apps, so you can also stream anything you buy easily that way too.
