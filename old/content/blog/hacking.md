---
kind: article
created_at: "2011-11-09"
title: Hacking The Parliament
---
I’m just back from a weekend long trip to London where I took part in [Rewired State’s Parliament Hack](http://rewiredstate.org/events/parliament).  It was a really fun weekend, starting off with a guided trip round the House of Commons and House of Lords (smaller than they look and with amazing streampunk-like brass speakers embedded into the benches) and then it was all back to The Guardian’s offices for 36 hours of code and collaboration.  First up through a rallying cry from Lord Jim Knight who turns out to be a very throughful fellow.

Parliament Hack was being run as part of [Parliament Week](http://www.parliamentweek.org/) which aims to help people improve their understanding of both the parliament and democracy.  By opening up a bit of data and letting 40 or so geeks run riot over it a stack of projects were built that help people interact or understand the inner workings of our government a little better.

So what did I build?  Firstly I got my head down and built [Oh Lordy!](http://ohlordy.theapproachablegeek.co.uk/) a reasonably simple mash-up making it easy to search the House of Lord Register of Interest.  This data is already published but it’s grouped by peer, which is interesting but not that handy.  Wouldn’t it be more interest to be able to search the register to see who has interests in say… Tescos?  That’s what Oh Lordy does.  It’s a mix of mongodb, codeigniter reactor and the data was crunched using python and beautifulsoup.

On Sunday morning (after a few hours sleep under a desk) I started looking at the rather excellent unemployment data.  It’s really detailed and goes back years.  Unfortunately it was supplied in an Excel spreadsheet which isn’t brilliantly handy.  Using the same tool stack I built the UK Unemployment API to liberate the data.

I won a prize for [Oh Lordy!](http://ohlordy.theapproachablegeek.co.uk/) too, which was nice, and whilst presenting  UK Unemployment API found out that the thing I had built already exists in the form of [NOMIS’s API](http://www.nomisweb.co.uk/api/v01), and bloody good it is too.  Oh Lordy! also [got tweeted about by Lord Knight](https://twitter.com/#!/jimpknight/status/133120837506170880) too, which was pretty cool.
