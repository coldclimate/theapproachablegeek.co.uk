---
date: "2012-09-30"
title: What homebrew weather tracking can teach you about USB debugging
tags: ["tinkering"]
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
I bought a [cheap and cheerful weather station](http://www.maplin.co.uk/usb-wireless-weather-forecaster-223254) a few years ago because it was on offer in Maplins (yes, I shouldn't be allowed to go the on my own).  Seeing what the weather is up to is interesting enough, but generating graphs and tracking over time is much more interesting.

Luckily, the weather staions wireless display had a USB socket on the side and with a little Googling it turned out to be not too difficult to get working.  Along the way I picked up some really handy tips of debugging USB stuff too.

As a general rule most own-brand electronics is actually rebranded stuff, and this turned out to be true.  The wisdom of the Internet pointed me to [PYWWS](http://code.google.com/p/pywws/) which is a set of Python libraries for reading the data of a huge range of weather stations, including mine.  Plugging in the weather station remove and firing up PYWWS didn't quite work first time, it looked like the scripts couldn't find the device and/or access it /dev/ttyUSB0 where the device conneted to.  What is needed is a udev rule to make it available to me.  

Luckily there are lots of examples online, though they didn't quite work for me

First step - working out what the device calls itself.  Tailing /var/message and plugging the device showed up the following

``[72488.473654] generic-usb 0003:1941:8021.0007: hiddev96,hidraw2: USB HID v1.00 Device [HID 1941:8021] on usb-0000:00:1a.7-1.2/input0``

The interesting bit here is "1941:8021" which is the device identifier which means I can write my udev rule

``SUBSYSTEM=="usb", ATTRS{idVendor}=="1941", ATTRS{idProduct}=="8021", MODE="0666", GORUP="admin"``  

Udev rules are fiddly, but luckly there is a way to test them, saving hours of time.   Step in "lsusb", and our reference numbers from the previous step.

``Bus 001 Device 004: ID 1941:8021 Dream Link USB Missile Launcher``

Woah!  My weather station identifies itself as a USB Rocket Laucher! However cool this is, the useful bits here are the bus and device numbers because it means my weather station is available on "/dev/bus/usb/001/004"

This means we can now run ``udevadm test /dev/bus/001/004`` which points out my type (damn it!), and leads to the corrected udev rule

``SUBSYSTEM=="usb", ATTRS{idVendor}=="1941", ATTRS{idProduct}=="8021", MODE="0666", GRoUP="admin"``
I store mine in a 

Restarting udev with "service udev restart" resulted in the weather station now being detected.

PYWWS has some great scripts for both pulling data from your weather station and generating graphs an with a little bit of crontab, scp and scripts, here they are live and updated every few hours.  It's worth nothing that the week and month graphs are pretty dull at the moment as they're only a few hours old.


![A day of Gateshead weather](/graphs/weather/24hrs.png "A day of Gateshead weather")
![A week of Gateshead weather](/graphs/weather/7days.png "A week of Gateshead weather")
![A month of Gateshead weather](/graphs/weather/28days.png "A month of Gateshead weather")






