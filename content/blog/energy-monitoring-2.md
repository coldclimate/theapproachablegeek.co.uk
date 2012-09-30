---
kind: article
created_at: "2012-06-22"
title: A return to energy monitoring
---
A year ago I wrote about using my Wattson to track my house energy monitoring. This week I finally got enough time to update my setup. My previous setup worked but involved some slightly ropey scripts. I’ve upgraded.  I’ve switched to using [rrdwattson](http://pikarinen.com/rrdwattsond/) which uses [rdd](http://oss.oetiker.ch/rrdtool/), the same technology that’s used for tracking server statistics.

One of the bonuses is my dodgy homerolled graphs are a thing of the past, behold my new shiny new daily, weekly, monthly and yearly graphs is all their splender, now updated every 5 minutes.

![A day of energy usage](/graphs/wattson/energy.png "A day of energy usage")
![A week of energy usage](/graphs/wattson/energy-1week.png "A day of week usage")
![A month of energy usage](/graphs/wattson/energy-1month.png "A day of month usage")
![A year of energy usage](/graphs/wattson/energy-1year.png "A day of year usage")





