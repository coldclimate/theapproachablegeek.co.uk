---
kind: article
created_at: "2010-09-03"
title: Sorting 11,000 photos
---
Recently a client caused me to scratch my head and have to put my thinking cap on. How do you make the most of the 11,000 photos they’ve taken over the last 6 years to help promote their business and find the value in a record of their work. I’ll cover what we did another day, because getting to grips with the photos was the first big problem.

As we all do (and I’m guilty of this) they’d not done anything about keeping their photos organised. 3 different cameras, 4 different computers and countless people over the years had resulted in duplication, miss-filing (some attempt had been made to put all of the photos about a subject into a folder), and worst of all, missing files.

Using a set of command line tools we were able to find all of the pictures on all the different computers, and copy them all into one place (a huge external hard drive). Now we had everything in one place we could start removing the duplicates and grouping the photos. A combination of tools ([exiftool](http://www.sno.phy.queensu.ca/~phil/exiftool/), find, grep, and bash scripting) renamed all of the pictures to the date they were taken on, and by grouping then by time we could then file them by client, spotting where one client’s photos had been plonked into another client. Where files were duplicates, they had the same name, so identifying them was reasonably easy.

Lastly, we’re now working on a filing system that is not just client based. For example the client might want to find all photos with Terracotta pots in them, hard landscaping, or [crambe maritima](http://en.wikipedia.org/wiki/Crambe_maritima) (they are landscape gardeners after all). The answer is finding a piece of software which supports tagging. We’ll file photos by client but tag them with subjects. It’s got to work on both Windows and Apple OS X, and play nicely with the distributed file system (provided by DropBox). It looks like Picasa might be the answer, but we’re still trailing it.

A few things you can do right now to help sort out your photos right now…

* Set the date and time on your camera, so the embedded EXIF data is better
* Turn on geolocation if your camera supports it
* Get into the habit of dumping all the pictures off the camera and then sorting them right away, then deleting the photos off the camera. You’ll end up with duplicates otherwise. 
* Set the filenames on your cameras to different things “bigSLR” and “pointShoot” for example. This means that your photos will * have different file names, bigSLR001.jpg for example. Reduces duplication and lets you work out what something is.
* Back up, back up and back up, but don’t just duplicate on the same computer. Use a tool like Rsync, to synchronise pictures onto * an external disk or another computer.
If you’re a photo professional, I’m guessing you’re using Lightroom, which does a lot of this for you.
