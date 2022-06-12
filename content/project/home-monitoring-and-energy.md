---
title: "Home monitoring and energy"
date: 2022-06-12T11:30:03+00:00
tags: ["monitoring", "tinkering"]
author: Me
# author: ["Me", "You"] # multiple authors
showToc: true
TocOpen: false
draft: false
hidemeta: false
comments: false
description: "A place for notes on home monitoring and maybe eventually solar and other energy stuff"
disableHLJS: true
disableShare: false
searchHidden: true
cover:
    image: "<image path/url>"
    alt: "<alt text>"
    caption: "<text>"
    relative: false
    hidden: true
---

I've been playing with home monitoring since before I first owned a house, but I've not been very good at keeping notes.

Recently I've started to get interested in solar panels for the house, and I'd like to be able to get data off them but it doesn't seem to be obvious which kit makes this easy (without using companies cloud services, which I don't really want to do), so I'm starting to make notes here.


# In house cameras

I've tried a few things.  Ideally I don't want to have video and audio from inside my house being streamed out.

## Early iterations

A variety (7 in total I was surprised to see) of "cheap" ip cameras under various brands (Foscam FI9826W, ieGeek 1080P, EIVOTOR 1080P).  I generally then googled hard enough to find an RTSP stream address and then wired this into Motion, running on a Linux laptop somewhere.  

Most of those cameras also have a URL which will return you a JPG on demand.  I used this for my project to record the sky for a year (I'll write that up at some point.)


## Using a SAAS product

I ran across [Neos](https://shop.neos.co.uk/) who sell a SAAS service with lovely little cube cameras that were pretty cheap (£20 each roughly).  At the time Neos were pretty new, and the app works well.  It looks like they have expanded into other home monitoring these days.

I really liked the app and service, it worked well, but I really ideally don't want my video leaving the building.  Luckily the cameras are rebranded generics, and the firmware is updatable, so that's leading on to my current iteration.

## Generic cameras, local recording, nightly sync

The little square Neos cameras are Xiaomi Xiaofang's running custom firmware (probably to power the very neat QR setup step).  I took [three](https://automatedhome.party/2017/12/18/modify-the-xiaomi-xiaofang-camera-to-work-with-home-assistant-and-other-video-recording-software/), [different](https://ryanfitton.co.uk/blog/install-dafang-custom-firmware-to-neos-smartcam/), [posts](https://www.youtube.com/watch?v=DD7mLfk_l9I) for me to be able to reflash with [Elias Kotlyar's Dafang firmware](https://github.com/EliasKotlyar/Xiaomi-Dafang-Hacks).

The process is pretty simple, but frustrating when it doesn't work, because all you get is a beep at best.  I ended up using...
* Kingston branded sdcards - I had a generic one that didn't work and given the price, I couldn't be bothered debugging in the future.  I used 32GB cards which give me plenty of storage, but not so much that I risk the OS getting twitchy.
* Use [this sdcard formatter](https://www.sdcard.org/downloads/formatter/).  This was key for me, without it, no matter how I setup the SD card, the cameras wouldn't pick up the interim firmware.
* Follow these instructions to [install the Defang firmware](https://github.com/EliasKotlyar/Xiaomi-Dafang-Hacks/blob/master/hacks/install_cfw.md)
* This got me 5 cameras up and running with live view over internal IP addresses on my home LAN, through a browser, which works well.
* I tried getting the cameras to move video files over FTP, but weirdly get AVI files [why](https://github.com/EliasKotlyar/Xiaomi-Dafang-Hacks/blob/ff726128711279f7020756f098dde8abbdc47094/firmware_mod/scripts/detectionOn.sh#L277), and it seemed a bit flaky so I most to a different method.
* Every camera is setup to do motion detect, save to the sdcard and retain for 10 days.
* A little RaspberryPi with a huge 120GB card runs as a sync server.  Every night it pulls all the video files for each camera and drops them into named directories.  Right now they're just stacking up, in the future I'll cut thumbnails, build a retention policy, etc etc.
* The sync script is naff because it pulls everything for that day, there's no sync state.  That's because when I try to use rsycn I got some crypting error messages (below) that I've not figured out yet.  Lucky ssh is there so bash and keys to the rescue.
* ``` The error messages:
sh: rsync: not found
rsync: connection unexpectedly closed (0 bytes received so far) [Receiver]
rsync error: error in rsync protocol data stream (code 12) at io.c(228) [Receiver=3.2.3]
```
* ```
The shonky syncing script


#!/bin/bash -x
DATEO=$(date +%Y-%m-%d)

export DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
for LINE in `cat ${DIR}/driver.txt`
do
  IP=$(echo $LINE | cut -f1 -d"_")
  DEST=$(echo $LINE | cut -f2 -d"_")
  echo "Working on ${IP} ${DEST}"
  mkdir -p ${DEST}
  for FILE in `ssh root@${IP} "find /system/sdcard/DCIM/motion/Videos/${DATEO} -type f"`
  do
  scp root@${IP}:$FILE ${DIR}/${DEST}/
  done
done

# This is called by a crontab entry
58 23 * * * /home/pi/Documents/remote/getCams.sh

# Yes, using the root user on the cameras it's great here
```

# Energy monitoring

## Wattson

I spent a lot of money on a [DIY Kyoto Wattson](https://www.diykyoto.com/wattson/about) and loved it for years.  It was a pretty object (important if it's going to live in your living room), and thanks to some libraries [maybe these ones](https://pikarinen.com/rrdwattsond/) I was able to get data out over USB.  For a while it was hooked to an old laptop I was using as a media settop box behind the TV.

I'm not sure why I stopped using the Wattson, but I think it broke.  Recently I picked up a broken one at EMFCamp and I plan to recycle the case into a nice home for the Pi mentioned above.

## OVO API

If I can't pull data from devices in my house, I'll start investigating [this library that pulls from their api](https://github.com/timmo001/ovoenergy)
