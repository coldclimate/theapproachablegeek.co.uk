---
kind: article
created_at: "2013-09-01"
title: My Wattson is dead, long live Wattson
---
I've been facinated with tracking things for years, so I splashed out years ago and bought a [Wattson](http://www.diykyoto.com/uk/).  It's a beutiful thing, which makes havign an energy tracker in your living room more likely.

Sadly this week I noticed that Wattson wasn't updating then I turned the lights off.  I tried jigglgin the clips round the cables under the stairs but to no avail.  I reset him and he sprank to life, sadly only for a couple of hours and then he got stuck on 149W again.  Sadly, I think my Wattson has died.

One of the things I've loved about my Wattson is how as I've adapted it for my needs I've seen the company who make them make simalar adaptions.

# Getting rid of the batteries
One of the first adaptions I made was to get rid of the need for 4 AA batteries in the transmitter.  I always forgot to relpace them and they seemed wasteful.  I spot soldered the terminals from an old Nokia power supply into the battery compartment.  The voltages were's quite right and I had to duct tape the cover back onto the transmitter but it worked.  Wattsons now come with a power supply.

# Getting data out
Wattson was cool, sitting in my living room and facinating a series of housemates, but the software Holmes was terrible.  It was (is? I've not looked in a long time) Flash based, it didn't run on my Linux box, and it was a batch transfer, not realtime.  Sadly Wattson and DIYKyoto weren't very open about how to get data out (I think this is where their business model might have been tryign to go) but step forth The Internet.  

Over the course of 5 years I've used a couple of different librabies ([rrdwattsond](http://pikarinen.com/rrdwattsond/) and [openwattson](http://dialog.hut.fi/openwattson/)) to pull data out and try and do things with it.  I build graphs, I put them online, I tried to do some ananlysis by pushing data into toold like Redis.

Gettting Wattson online was a big step for me, and involved a steep learning curve (it all looks so trivial now in retrospect, but it was tough at the time.)

Roll forward and DIY Keyoto step up and launched WattsonAnywhere, which does all I tried to do and more.

# A company that listens to it's community
I can't help wondering if the makers of Wattson watch what the fringes of their userbase are doing and try to emulate it.  It's a smart move, as pointed out by Matt Mason's excellent book [The Pirates Dilemma]http://thepiratesdilemma.com  Want to know what your customers really want - look at what they are fighting hard to do themselves.

# Will I replace him?
I don't know if I will get a new Wattson.  I'd like to, but they are not cheap.  I've just signed up for a [British Gas EnergySmart](http://www.britishgas.co.uk/products-and-services/gas-and-electricity/energysmart/electricity-monitor.html) and I'm hoping I can hijak it, but if this doesn't work, I'll be buying another Wattson in a heart beat.
