---
kind: article
created_at: "2013-10-27"
title: Inspecting messages in a RabbitMQ queue, ghetto style
---
There are probably a lot of much better ways to do this, but recently we needed to get at a couple of messages in a  [RabbitMQ](http://www.rabbitmq.com/) queue.  It's a dead letter queue and we'll built a better tool to process it's messages at some point, but right now we just needed to get hold of one of the messages in it, without removing them all (and loosing them).

> TL;DR There SSH tunnel into the box, mod an API call nicked from the browser to use it's cookies to authenticate, format it using jq and then grep out what you need.  It's not clean, but it will always work and requires virtually no tools.

## The scenario
By design you can't peek into a message in a Rabbit queue.  The queue in question is on a remote box I can't install anything on and only have ssh access too.  Luckily it does have the [RabbitMQ Management Plugin](http://www.rabbitmq.com/management.html) installed, and that's the route in.

## The steps

Getting our one message involves gluing a bunch of steps together, namely...

* SSH tunnelling to allow access to the management plugin form my local machine
* Capturing an API request and modifying it
* Dumping this requests returned data to file
* Formatting it so we can use other tools to find the message we want


### The tunnel

SSH tunnelling is super powerful.  If you've got SSH access to a box you can basically route your traffic to that any destination port on that machine, but proxying through your machine.  Sounds like a horrific security hole at first but is actually pretty safe.

	ssh -L 12345:localhost:15672 rabbit.remoteserver.com

Here we're setting up a tunnel from out local machine's port 12345 to the remote (fictitious) servers port 15672 (the Rabbit Management port).  I'll have to authenticate the ssh connection, but once i have I can stick http://localhost:12345 into my browser and hit the remote server, where I'm asked to log into Rabbit.

## Capture an API call

You can hit the RabbitMQ API from the commandline.  In this case I'm not going to, I'm goign to let the browser to the work, then hijak it.

In Google Chrome, I head to the queue I'm interested in, pop open developer tools, and select the network tab.  Now I can see all the urls requested and the responses.  Back in the page I head to Messages, make sure that Requeue is selected and increase the count of the messages I want to pop off to 2, then hit go.  In the network tab I can see the request whizz through and in the page I can see the 2 messages that were at the head of the queue.  If the queue is only short I could pop off (and requeue) a few hundred to get the one I want, but in this case it's buried 10,000 messages back (I think).   So instead click on the network request which was the API call (it looks like a GET call to http://localhost:12345/api/queues/My_Exachange/Problems/get'), right click and select Chrome's excellent "copy at CURL request", then paste it into a text editor.

### Modify it

It's a big statement but the interesting bit for us is the "count" on the end.  We need to up this from 2 to as many as is required to make sure our message is in the bulk that are sent back.  In my case this is 10,000

	curl 'http://localhost:12345/api/queues/exchange/Problems/get' -H 'Pragma: no-cache' -H 'Origin: http://localhost:12345' -H 'Accept-Encoding: gzip,deflate,sdch' -H 'Host: localhost:12345' -H 'Accept-Language: en-US,en;q=0.8' -H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_7_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/30.0.1599.69 Safari/537.36' -H 'Content-Type: text/plain;charset=UTF-8' -H 'Accept: */*' -H 'Cache-Control: no-cache' -H 'authorization: Basic [REDACTED]' -H 'Cookie: auth=[REDACTED]; m=[REDACTED]' -H 'Connection: keep-alive' -H 'Referer: http://localhost:12345/' --data-binary '{"vhost":"/[REDACTED]","name":"Problems","truncate":"50000","requeue":"true","encoding":"auto","count":"1000"}' --compressed

### Dump the data to file

If you past this into the command line you'll be returned a single huge line with 10,000 JSON encoded messages.

	curl 'huge statement above' >> messages.txt

### Format it and search

Now we have a single line huge file, containing a JSON formatted list with each entry being a message.  Good start, but difficult to manipulate.  Luckily [jq](http://stedolan.github.io/jq/) makes this easy to fix.  jq is "sed for JSON" and extremely handy.  Here's we doing nothing more than asking it to format and spit out the messages.

	cat messages.txt | jq '.' >> messages.json

Now we have a 40,000 line file.  Each Rabbit messages has the same format and how you identify the specific message you want will probably depend on how you now refine messages.json.  In my case I can use the timestamp to get my message

	grep 1382867490 messages.json

And there she is, the pesky rotter which has been derailing my batch processor, time to raise a bug report.


## A better way?

Writing this up I can't help thinking of this [excellent XKCD cartoon](http://xkcd.com/763/).  

![Workarounds](http://imgs.xkcd.com/comics/workaround.png "Workarounds")

It seems convolved and bity, and I'm sure I'll be embarrassed about it in the future.  With libraries like [Pika](https://pypi.python.org/pypi/pika) around I'll probably write a script to do this in a more efficiant manner at some point, but right now it just saved my arse so I thought it was worth sharing.
