---
kind: article
created_at: "2011-05-10"
title: Culture Hack Scotland
---
[Hack Days](http://en.wikipedia.org/wiki/Hack_Day), like [BarCamps](http://en.wikipedia.org/wiki/BarCamp) before them, are a phenomenon that went through the geeky community like a dose of salts, and have then worked their way sideways into other communities. A hack day involves getting a bunch of people (coders, designers, ideas people, subject matter experts) together for a 24hour+ session, where they make things. Very often hack days will be themed around a subject, often related to their hosts. The hosts are often making a range of data or services available for people to built things with.

What comes out of the room when you give geeks data and some time to play with it (also with food and coffee) is frankly amazing.

I was lucky enough to be[ awarded a travel bursar](http://culturehackscotland.com/oli-wood-awarded-first-chs11-travel-bursary) for [Culture Hack Scotland](http://culturehackscotland.com/) last week, and so headed up to Edinburgh on Friday afternoon to bash out something (at that point unknown) using the amazing data sets that had been provided.

After a bunch of welcome talks and a few glasses of white wine, we got down to bashing ideas around and coding. I really wanted to work with the footfall data provided by City of Edinburgh Council. It has the number of people to pass 19 spots around the city for the last 365 days, in the form of Excel.

Lots of the data provided was historical (2010′s Festival data for example) because the 2011 data is not ready yet, however it’s all in the same format, so hopefully anything built on top of the 2010 data could be adapted to run in 2011.

When I started working with the footfall data it became apparent that whilst it was clean and neat (unlike a lot of publically available data) it was not very useful in a spreadsheet. What would have been lovely was a queryable API, where you can ask for the data for a given day, or venue, or day and venue, and get back a set of numbers. This was what I decided to built. It wasn’t going to be pretty or shiny like some of the works of art, but it would turn out to be very useful.

So, by Sunday morning, it was live. [http://edinburghfootfall.theapproachablegeek.co.uk/](http://edinburghfootfall.theapproachablegeek.co.uk/) provides a set of end points which return nice clean JSON data. JSON seems to be the data type of choice for most web apps and API mashups these days, and it’s lovely to code with. Over the next few weeks I’ll update the API to add in some more filtering and hopefully keep it live for as long as it’s useful.

There [were lots of amazing hacks produced](http://culturehackscotland.com/showcase) over the course of the weekend, and I was blown away not just by the quantity but also the quality. 24 hours really is a long time at times.

Edit (6/6/2010) Some of the hack (including one based on the data I made available) made it into the Guardian Data Blog!