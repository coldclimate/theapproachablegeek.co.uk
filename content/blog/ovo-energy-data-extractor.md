---
date: "2022-06-18"
title: Getting your consumption data out of OVO Energy
tags: ["home monitoring", "data liberation"]
author: Me
showToc: false
TocOpen: false
draft: false
hidemeta: false
comments: false
disableHLJS: true # to disable highlightjs
disableShare: false
searchHidden: true
---

I've been a happy customer of [Ovo Energy](http://www.ovoenergy.com) for many years, since they were titchy, though they seem pretty big these days.  One thing that frustrated me is since I got a smart meter there's lots of fine detailed information being created and I can't get at it, which boils my pee, because that's my data, and I want it.

Today, I finally got angry enough to get motivated, and so after 3 hours of piddling about, figured out how to liberate it in a very ugly way.  OVO don't have an official API, but if you log into their site you can get get graphs and info, which is great for lots of folks, but not geeks, and especially not those who would like to do things like keep a long history or write integrations.  However, it's there, and a browser can get to it, thus so can I.

If you open up the network tools in your browser you can see traffic to `smartpaymapi.ovoenergy.com/usage/api/half-hourly/[accountid]` that's getting JSON returned.  The game is afoot!

Not wanting to reinvent the wheel, I googled around a bit, found somebody who'd written a Home Assistant plug-in to pull the data, had a play (I've not got Home Assistant,so I just hacked on the Python itself) and didn't get very far.  It's Saturday afternoon, and so I broke out my usual toolkit and knocked up the following script.

```
#bin/bash

d="2018-07-02"
until [[ $d > 2022-06-18 ]]; do 
    echo "$d"
curl REPLACEME --output $d.json --compressed
    d=$(gdate -I -d "$d + 1 day")
#sleep 1
done

``` 

It's running on my Mac so uses GNU date which you can install with `brew install coreutils`.  gdate takes standard inputs, unlike the weird date command that runs on OSX.

This loops though all the dates between 2018-07-02 (contract date with OVO) and today, making a curl call and dumping the output to a file.  I was originally nice and slept a little between calls but the authentication token expired and so I decided that if they weren't going to play nicely with making data export available, I wasn't going to play nice with their API rates.  This is probably wrong.

To get it to work you need to replace REPLACEME with an actual curl call which you can crib from your browser.

![Oh, oh, yeah, When I hold you baby, Feel your heart beat close to me (oh, oh, yeah), Wanna stay in your arms forever, Only love can set you free, When I wake each morning, And the storm beats down on me, And I know we belong together, Only love can set you free, Set you free, Set you free, Set you free, Set you free, Oh, oh, yeah](/images/copy-as-curl.png)

1. Log into My Ovo and head for [Usage](https://account.ovoenergy.com/usage)
2. Head to the "Day" tab and choose "Both fuels"
3. Pop your network tab open in Developer Tools and look for a call to `smartpaymapi.ovoenergy.com/usage/api/half-hourly/[accountid]`
4. Right-click it, and choose "Copy as Curl"
5. At this point you've got until the token expires, so get a wiggle on - paste the call into a text editor so you can mangle it to make it fit for purpose
6. Replace the date in the URL with $d - the bash script will insert dates into this
7. Remove the "br" from  `Accept-Encoding: gzip, deflate, br'`
8. Replace REPLACEME in the BASH script with the results of your edits
9. Execute the script and watch the JSON files pile up.

The bit that took me ages was figuring out "Remove the "br" from  `Accept-Encoding: gzip, deflate, br'` ".   [Brotli](https://en.wikipedia.org/wiki/Brotli) isn't supported by curl (yet), so by removing it from the request header, you don't get served it, and curl will dump the raw JSON (neatly uncompressing it from gzip thanks to the --compressed flag).  

What does it get you?  30 minute interval data about your gas and electricity usage, in a reasonably consumable format.

```
{
    "electricity":
    {
        "data":
        [
            {
                "consumption": 0.084,
                "interval":
                {
                    "start": "2022-06-06T00:00:00.000",
                    "end": "2022-06-06T00:29:59.999"
                },
                "unit": "kwh"
```

What next?  No idea!  I'll probably build some graphs off it, like their website does, but that doesn't matter, the important thing here is it's mine, and I now have it.