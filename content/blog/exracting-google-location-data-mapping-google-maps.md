---
date: "2014-10-12"
title: Extract location data Google has about you, and stick it on a map
tags: ["data", "bash"]
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

I love my Android phone, its great having a bit of kit I can mess with but that just works out of the box.  Since Google retired Google Latitude I'd forgotten then my mobile knows exactly where I am and generally I don't mind this, it helps my phone show me smarter information, but it's my data and damn it, I want it.  Eventually I'll get round to writing a simple backend to store my location (it's yet another thing I didn't do in my time off), however I'd like to get out all my historic data.

Luckily it turned out to be reasonably easy.  Whilst browsing the [Google Location History](https://maps.google.com/locationhistory) page I noticed a link called "Export to KML".  Clicking on it gives you that days data.  Looking at the URL it included a couple of time stamps.  Well those look hackable...

	https://maps.google.com/locationhistory/b/0/kml?startTime=1413068400000&endTime=1413154800000

That looks like a millisecond based time stamp and so with the help of [epochtimeconverter.com](http://www.epochconverter.com/) I generated one that covered this year to date (1388534400000) and dropped it into place.  10mb download later an whoop whoop - everywhere I've been in 2014 (and a few false readings).  You can also replace the first timestamp with 0000000000000 (1st jan 1970) to get all the locations though weirdly in my case this only goes back to the beginning of the year.

Now to get this data into something you can looks at, namely Google Maps. You can import KML into custom maps but there is an upload limit of 3mb.  Luckily KML is a very readable so a quick poke showed I could split the file then pop the headers and footers into place

	split -l 20000 history.kml

This produced 3 files, one with the header in it, one with just list of locations and one with the footer.  A quick bit of cut and paste later I had three files which I could import.  If you're unsure of what to cut and paste open the original file and look for the first pair of tags that look like this.  Everything above it is the header.  Scroll to the end and look for the last pair and everything below it is the footer.

	<when>2014-05-12T03:41:09.593-07:00</when>
	<gx:coord>-1.917725 55.9699655 0</gx:coord>

The end result - messy but functional, however the export technique might lead to more interesting investigations.


![Roughly where I've been](/_assets/uploads/locations.jpg "Roughly where I've been")

