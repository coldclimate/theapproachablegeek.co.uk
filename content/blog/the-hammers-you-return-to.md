---
kind: article
created_at: "2015-12-19"
title: The hammers you return too
---

I recently posted [Everything I bought from Amazon in 2015, reviewed](everything-amazon-reviewed-2015), and compiling the list turned out to teach me an interesting lesson.  

Compiling the list of everything I bought should have been so easy.  Amazon provide a page called "Your Orders" which lists everything and is paginated.  It's also reasonably well structured too so it all seemed pretty simple.

## Plan One: Xpath selector in browser

In the Chrome dev tools there's a handy function $x() which lets you run XPath statements fro inside the [Chrome console](https://stackoverflow.com/questions/3030487/is-there-a-way-to-get-the-xpath-in-google-chrome).  It should have been a simple matter of crafting a selector that pulled out the links, grabbing the href value and the text inside the link, bish, bash bosh and away I go, right?  Wrong.  Add in some slightly wonky structuring, Xpath being a pain at the best of times and a stinking cold leads me to 2 hours of wasted time and a right grump on.

## Plan Two: Beautiful Soup

Can't do it in the browser? Fine - lets just use Chrome's "copy request as curl" functionality to let me grab the pages and download them, then parse them with [Beautiful Soup](http://www.crummy.com/software/BeautifulSoup/) and split out the links.  Soup is a great library to work with, often dealing with crappy markup beautifully.  This time however, nothing.  Much head scratching and cursing later, the cold is driving me up the wall and I've had several large scotchs, it's time to realise that sometimes you need to break out the hammer.

## BASH hammer + scrappy Python

Many year ago I was very stuck by an article called [Taco Bell Programming](http://widgetsandshit.com/teddziuba/2010/10/taco-bell-programming.html).  The ideas it put forward and my level of illness lead me to breaking out my default tool set - BASH and some (frankly crappy) Python scripting.

1. Download and save each page of my orders manually.  Sod doing this with curl, there are only 8 of them.
2. Grep out all product links because they handily have "gp/product" in them.  ```grep "gp/product" *.html | sort | uniq >> links.unique```
3. Annoyingly the href's where split over multiple links so I've got the link but not the title.  Python to the rescue - loop though each product link, grab it, pull the title and then spit it all out as Markdown ready for the page (and bin off anything that errors because; sod it)

```
import urllib2
with open("links.unique") as f:
	content = f.readlines()
	for link in content:
		try:
			soup = BeautifulSoup(urllib2.urlopen(link).read(), 'html.parser')
			print ("[%s](%s)" % (soup.title.text,link))
		except urllib2.HTTPError, err:
			print
```

## Jesus this is a mess, why didn't you just get Xpath to work?

I should have. I'm sure that on a good day I could have got Xpath in browser work, or been smart about how I parsed the pages with BeutifulSoup, but the ability to fall back on a hugely powerful set of simple tools and glue them together meant that even through I resembled some sort of bog monster and could barely type I could still knock something out even though it's far from efficient or beautiful. Get shit done.