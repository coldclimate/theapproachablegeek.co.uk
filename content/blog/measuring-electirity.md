---
date: "2011-01-06"
title: Measuring electricity usage for your business
tags: ["data"]
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
For a few years I’ve been interested in reducing my environmental footprint, and the footprint of my business. Working from home this naturally means reducing the amount of energy my home is using. The first step on this road is measuring how much energy you use, and to a certain extent being aware of how much energy you’re using will lead to you reducing the amount.

To this end I bought a [Wattson](http://www.ethicalsuperstore.com/products/diy-kyoto/wattson-home-energy-meter/) a few years ago, a really beautiful energy monitor. It comes in two pieces, a transmitter which clips to your power cable near the meter, and the readout.

As well as giving you a numerical readout of your energy usage it gently glows to rate your current usage from blue (low) to red (high). It’s an astoundingly compelling piece of kit, more expensive that other energy monitors, but one you’d happily have in your living room (and thus actually look at).

I’ve wanted to record my energy usage, display it online and track it, since I got the wattson, but it’s not quite as easy as I hoped. The Wattson does record the data, but to get it off you have to plug it in by USB and then use a Flash application to download it. Whilst plugged in the Wattson is not recording (which is annoying) and the software doesn’t work well on my computers.

Ideally I wanted to leave the Wattson plugged into my home server all the time, recording and posting the info online, and it turned out a few little hacks made this possible.


The rather beautiful Wattson readout unit
Firstly, I’ve got a rather old Wattson and thus the transmitter is battery powered, which is not ideal.  The new transmitters can be mains powered, but with a little soldiering my Wattson transmitter is now mains powered, making use of an old Nokia power transformer to replace the 4 AA batteries. It’s not a pretty hack, but it was simple and functional.

Secondly my Wattson is now permenently connected to a computer. I have a little Linux powered laptop that serves up data to the house (including my webcam on the bird feeders) which is turned on all the time. It’s an old Toscheba I got for free and is running Ubuntu linux.

Connecting the Wattson via a USB cable, I can get data off it via a little utility that’s been developed independently of DIY Kyoto (who make the Wattson) called [openwattson](http://www.stok.fi/openwattson/). With a little bit of scripting my server now pulls the current energy rating off the Wattson, adds it to a log file for the day, and pushes it online.

This means that for every day I get a text file with an entry for every minute with the amount of energy I’m using. With a little bit of PHP scripting and Google Charts this can then be turned into a neat little graph for each day, like the one below. The current live data page is online now