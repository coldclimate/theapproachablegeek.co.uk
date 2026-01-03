---
date: "2026-01-03"
title: Recording the sky in 2026 with scripts and old hardware
tags: ["bash" ,"command line", "project", "photography", "linuk"]
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

Many many years ago I stood in a queue at MakeFaire Newcastle (maybe around 2010?) and chatted to an American chap, name long forgotten, who mentioned his friend who had pointed a digital camera at the sky somewhere in the US (Bay Area?) and was taking a picture every minute to create a giant art installation.  I did eventually track them down (they blogged about it) but I can't find the link or remeber any of the names invlved.

10 years later I was living in a house that made this more achievable, so I gave it a got.   I reused some of the sctipts and kit from [my over engineered greenhouse for growing chilli](https://www.theapproachablegeek.co.uk/blog/raspberrypi-greenhouse-timelapse-graphs/) and thought the power of ductape and cardboard boxes, mounted a decent webcam to our spare bedroom window, angling it to avoid any of the neighbors.  An old laptop provided the computing power, and with a combination of BASH, cron and ffmpeg, it took a picture, every minute, for a year.

The camera is mounted inside the house, which makes reflections off the glass of the window frustrating.  I tried mounting the camera outdoors, but I don't have a suitable enclosure to keep it dry enough in the North East weather.

Every minute, a command line script fires up the camera, takes an image, and saves it to disk with a sensible name.

Every night, a set of scripts fire up and produce a few different things...

* A mosiac of the day, one row per hour
* A timelapse of the day, 24 frames a second, makes for a rather neat 60 second runtime
* A keograph (I think this is the right name) of the year so far, one row per day.

Because I screwed up the timezones, the keograph has an annoying step out in it but...I rather laike it.  I can't explain the black stripe on it around April - I guess the camera wasn't taking pictures for some reason.

A note on using old laptops not single board computers like Raspberry Pi: I have them available.  The have a battery which works as a low cost PSU.  They're very early to get linux to run on and install random libraries (this is now true of Pis).  They usde more power than single board computers but really not that much.


## The scripts


### Grabbing a frame

```
#!/bin/bash -eu

export DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
export DIR_DATE=$(date +%Y_%m_%d)
export PIC_DATE=$(date +%Y_%m_%d_%H_%M)
mkdir ${DIR}/${DIR_DATE}/ || true
fswebcam --device V4L2:/dev/video0 -D 2 -S 20 --resolution 640x360 --frames 1 --delay 1 --no-banner --no-timestamp  --save ${DIR}/${DIR_DATE}/$PIC_DATE.jpg
cp ${DIR}/${DIR_DATE}/$PIC_DATE.jpg ${DIR}/latest.jpg
```

Very ugly, but functional.  A few notes...

* fswebcam might not be perfect, but it worked with my camera right out of the box so I'm running with it.
* the "delay 1" is to give the camera a change to settle down
* Video4Linux2 commands where handy to work out how my camera was presenting itself
* There's probably a smarter and cleaner way to do the directory stuff, but this works and some of my other scripts that are invoked by cron have suffered, so I now just use this


### Nightly compile
```
#!/bin/bash -u
export DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
export DIR_DATE=$(date +%Y_%m_%d --date "yesterday")

# 24 frames a second + 1 photo every minute = video is 1 minute long
ffmpeg -r:v 24 -pattern_type glob -i "${DIR}/${DIR_DATE}/2*.jpg" -codec:v libx264 -preset veryslow -pix_fmt yuv420p  -crf 28  -an ${DIR}/rendered/${DIR_DATE}.mp4
ffmpeg -pattern_type glob -i "${DIR}/${DIR_DATE}/2*.jpg" -filter_complex scale=120:-1,tile=41x35 ${DIR}/rendered/${DIR_DATE}_complete.jpg


#mosiac
ffmpeg -pattern_type glob -i "${DIR}/${DIR_DATE}/*.jpg" -filter_complex "scale=60:-1,tile=60x24" -update true ${DIR}/rendered/${DIR_DATE}_mosiac.jpg
cp ${DIR}/rendered/${DIR_DATE}_mosiac.jpg ${DIR}/rendered/mosiacs/${DIR_DATE}_mosiac.jpg

# strip
ffmpeg -pattern_type glob -i "${DIR}/${DIR_DATE}/*_?0.jpg" -filter_complex scale=60:-1,tile=240x1 -update true ${DIR}/rendered/${DIR_DATE}_strip.jpg
cp ${DIR}/rendered/${DIR_DATE}_strip.jpg ${DIR}/rendered/strips/${DIR_DATE}_strip.jpg

# Year to date
ffmpeg -pattern_type glob -i "${DIR}/rendered/strips/*.jpg" -filter_complex tile=1x365 -y ${DIR}/rendered/year.jpg
```

Notes:
* glob patterns are much easier if your files are well named
* using `-1	` in the scale function is a neat way to maintain aspect rations
* I tried to use ImageMagic and other things to compile the images, but in the end I already had FFMPEG there and there are lots of great examples online so I JFDI'd it


## The results

### The last day of 2025
The annoying white dots are a reflection on the glass of the window I intent to sort in 2026
![every minute of the 31st of December](/images/2025_12_31_complete.jpg)



### Keograph 2025
![Every minute of 2025](/images/2025-keograph.jpg)




