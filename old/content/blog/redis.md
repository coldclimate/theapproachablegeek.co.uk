---
kind: article
created_at: "2011-11-25"
title: Dabbling with Redis
---
Over the last few years I’ve heard more and more about NOSQL (Not Only SQL, not No SQL) techniques and technologies but had limited time to experiment.  Luckily a project came along which was a perfect fit for making use of two, [MongoDB](http://www.mongodb.org/) and [Redis](http://redis.io/). It’s taken me a little bit of time to start to get my head around either but Redis specifically has helped unlock a whole swath of interesting bits and pieces.

Redis is a key-value store, making is very fast and easy to push bits of data into a store without them having to fit into a per-defined schema.  It’s got [great drivers](http://redis.io/clients) for all of the languages I work in too as well as a command line interface.  Getting it up and running was reasonably simple thanks for Ubuntu’s apt-get command.  There are numerous great guides to Redis, [what it does](http://simonwillison.net/static/2010/redis-tutorial/) and how to get  started out there.

None of this will be anything new to hardcore geeks, but what surprised me was how I’ve ended up using Redis over the last few months.

A quick, dirty and brilliant cross program message queue
---------------------

I suddenly found myself using Redis as a job queue thanks to it’s easy lists.  I can push driver values into a list with one process and pop them out from another.  You can use it as a First In Last Out stack by pushing and popping from the same end of the list, or as a First In First Out queue by pushing onto one end and popping from the other.  Best of all I could push jobs in with one process (a website front end for example) and pop them off with another (python scripts on the command line maybe).  Redis made this first step into cross process jobs trivial, in fact I did it without realising it.

A self-sufficient error log
---------------------

Redis supported fixed size collections known as capped collections.  Sometimes it’s very useful to has a running log of what’s going on inside a program and logging is the way to do this.  Most frameworks have mechanisms to log out to a file on disk which is great but it leaves lots of things to think about at some point including managing the files, watching their size etc.  If you don’t need to keep this data for a long time, Redis provides a super quick to implement and very efficient running log.  Push log entires into it, read them off on an admin screen, forget about having to look after anything.  Also, given the ease of sharing a Redis instance between different processes you’ve suddenly got a a system wider logger with all the help that brings.

A handy store when data mangling
---------------------

I’ve ended up doing a lot of data crunching over the last ten years.  A lot of this involves writing one of scripts to tear up text files and squirt out bits of it into a more usable form.  It’s hacking at it’s most pure I believe and having a mixed bag of tools to throw at problems is really helpful.  Being able to bolt together bits of perl, shell script, awk, sed, php, python and even Microsoft Excel is very powerful.  Often data crunching is a multi-step process with each step being glued together by squirting out data into text files and then reading it into the next step.  Because I can push data into Redis from a bunch of sources easily it has become an excellent binary-safe alternative to text files.  One script rips something up and pushes bits of it into Redis lists or keys, the next pulls out the bits it needs, and away we go.

I’ll probably write up my adventures in MongoDB at some point, but not just yet.