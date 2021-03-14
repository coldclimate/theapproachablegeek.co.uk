---
date: "2016-02-20"
title: Turning off all retweets 
tags: ["twitter", "python"]
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

## The back story
 I realised one day this week that I retweeted far more than I wrote actual tweets, and whilst these thing were generally important or interesting to me, because they were so much easier to post I was retweeting four five tweets in quick succession and probably pissing people off.  So I asked "who's got retweets turned off for me?" and the answer came back from four people that they ha, and not to be offended by it it was just how they used Twitter because it reduced noise and made Twitter more personal again.

 I decided I was going to do an experiment, see it this made Twitter more interesting again.

## Turning off retweets from everybody I follow

There's no way to actually do this though Twitter it turns out.  Luckily, Python and the API to the rescue.

First up install the only decent Twiiter API Python client (so far as I can see), twython

    pip install twython

Next go and create yourself an app so you can get a key/secret etc.  I can never find this page but it's called [Manage Twitter Apps](https://apps.twitter.com/)

And lastly a bit of ugly but effective Python.  Note, this doesn't take the paginated nature of the followers response into account because I had less that 1000 friends.

    from twython import Twython, TwythonError
    import time

    # twitter = Twython(APP_KEY, APP_SECRET, OAUTH_TOKEN, OAUTH_TOKEN_SECRET)
    twitter = Twython("REDACTED", "REDACTED", "REDACTED", "REDACTED")
    try:
        followers = twitter.get_friends_ids()
        for id in followers["ids"]:
	    print twitter.update_friendship(user_id=id,retweets=False)
        time.sleep(1)
    except TwythonError as e:
	    print e

## The result

966 lines of JSON output (I mostly dumped this out for curiosity) and a MUCH quieter timeline.  Next experiment is to find a way to highlight tweets from people who don't tweet very often.
