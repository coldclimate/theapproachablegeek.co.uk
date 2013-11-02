---
kind: article
created_at: "2013-11-02"
title: Cleaning up, deduplicating and sharing a large music collection
---

As part of my life declustering I've been trying to get as much of my digital life under control, including my significant music collection.  Over the years I've ripped my cds, copied files from other people, downloaded music from legal and illegal sources and never deleted a damned thing.  I've also got a CD collection that must be 500 CDs in total.  Over the last 2 months I've slowly got it all into one place, safe, and workable, but it's not been an easy ride.

> Tl;DR  Use EasyTAG, fduple and Picard to sort out meta data, then use 3rd party services to backup and stream it all.  No one-shot tools worked for me.

## The End Game
I basically wanted everything I owned, cleaned up and stored so than I didn't have to think about it.  Specifically that meant

* Each album in it's own directory
* All files with excellent meta data
* Title, Artist and Album Artist correct (no more tracks with the Artist listed as Various Artists)
* Everything backed up remotely
* Everything available across the house network for [Sono](http://www.amazon.co.uk/s/?_encoding=UTF8&camp=3194&creative=21334&linkCode=shr&tag=wwwcoldclimat-21&rl=search-alias%3Daps&field-keywords=sonos&sprefix=sonos%2Caps&rh=i%3Aaps%2Ck%3Asonos) to find
* Properly de-deuplicated, eg. no albums with 2 of each song, no albums in there twice with slightly different names.
* Nothing lost that I don't choose to loose.
* Ideally avalable when I'm at work

## The Process

It's taken me 2 months because it turns out it's not a point and press process.  I did try a few tools but nothing does exactly what you need.  I used a bunch of different tools, each to deal with a different process.

## Gather everything into one place

I had directories all over the place.  Backups of backups.  Sets of files I didn't dare delete in case there was something in there I wouldn't find again.  The first step was to drag all these into one place.  I bought a 1TB harddrive and copied any files I found onto it, each in it's wown directory.  No point trying to be clever at this point, the aim here was to make sure no man was left behind.  If I run across a "music backup (3)" directory in the future, I know I can delete it.

In total I got almost 600GB of files gathered up.  That's a lot of files.

## Dealing with "manual" playlists

I nearly ran a first pass deduplication at this point, and it would have been a mistake.  I noticed a whole bunch of directories which were playlists that my girlfriend had carefully compiled by copying files into a directory.  If I'd removed all identical files, these would have been deleted, because they are identical to whichever album they were copied from.

Step in [EasyTAG](https://projects.gnome.org/easytag/) which is really good at applying ID3 tags to whole directories.  I modified the tags of these files so that the Album Artist was set to "Various Artists", the Album was whatever the directory name was, and the Artist and Title were set correctly.  These files now are different from their source and we can move on.

### Super quick and dirty clean

Because there were backups of backups of copies here there were lots of files that could be removed.  The quickest way to nuke these is to use the file's checksum.  Step in [fdupes](http://code.google.com/p/fdupes/) and this rather scary (and slow) command.

	fdupes -r -d -N .

This took multiple hours to run (USB disks are not the fastest, if I did this again I'd find a machine I could get everything onto my local disk).  At the end of it I had 300GB of files left, so it had more than halved my collection.

## Ripping the CD collections

A tale for another time, basically I worked though nearly 500 CDs, ripping them all and making sure they had tip top meta data.  It took a long time, there's no fast way to do it, using multiple laptops and cardboard boxes for sorting is the only way.

## Sorting out the meta data 

So now everything in no the disk is likely to be something I want to keep, but it's a mess.  Some files are in directories by artist (so compilations are spread across multiple directories).  Some files are called various variations of "Unknown".  Some have no meta data.

### Unknown files that look like they're probably albums

Tackling the second hardest first - directories full of files called "unknown" which have no meta data but look like they should be an album.  You could play them and try and work out what they are, but this will take forever.  Step in the magic of audio finger printing.  Using the (MusicBrainz)[http://musicbrainz.org/] database you can work out what a file is.  I used EasyTAG to work out what these unknown albums were and tag them. Easy, if a little slow.  If Musicbrainz wasn't able to work them out I gave them a quick listen in case, but mostly deleted them.

### Party directories

I had a few directories which had hundred of files, mixes of albumns and indevidual files.  [MusicBrainz Picard](https://musicbrainz.org/doc/MusicBrainz_Picard) was a life safer here, because it has a magic "group" function making it easy to sort the meta data of 200 individual files and get consistent tags across each album.

## Sorting out the crap albums

By now I had thousands of files (150,000 roughly) which I wanted to keep and which all had meta data that really was what they were, but it was very difficult to see if I had multiple copies of albums and whether they were complete or not (ther evis nothing more frustrating than having tracks 2, 4, 9 and 11 of an album).

A this point I imported everything into [Banshee](http://banshee.fm/), and now was a very painful exercise - manually cleaning up the albums which didn't have all their tracks.  There is not quick way to do this, I went album by album and any albums which didn't have all the tracks I either deleted or (if they were tracks I wanted to keep) changing their meta data to an album called Singles, Album Artist of "Various Artists" and maintaining the Artist.  End result, a huge album called Singles and thousands of complete albums.  This process took roughly a month of spare evenings. #pain

## Sorting out files on disk

At this point I've cleaned up most things and got rid of all the chuff, but the files are scattered all over the disk.  EasyTag has an excellent feature for renaming files.  I chose to put each album into it's own directory, names with a combination of Album Artist and Album Name (lowercased and spaces replaced with underscored for sensibility)

## Sharing locally

I run a Seagate GoFlex as a home NAS.  It's far form idea but it works.  Getting all the files form the local machine up to the NAS was best done by rsync.  Moving thousands of files over the network will take time no matter how you do it, but any interruption that stops it will mean you start again.  Step in rsync, it might be a bit slower but you can start up where you left off, and it works over networks happily (like scp)

	rsync -arv * music@nas.local:/shared/music

In total this took 15 hours but the  [Sono](http://www.amazon.co.uk/s/?_encoding=UTF8&camp=3194&creative=21334&linkCode=shr&tag=wwwcoldclimat-21&rl=search-alias%3Daps&field-keywords=sonos&sprefix=sonos%2Caps&rh=i%3Aaps%2Ck%3Asonos) picks it all up over Samba.


## The backup

I use [Crashplan](https://www.crashplan.com), and luckily because of thier unlimited plan, the only problem here is getting 200GB+ uploaded.  Poor old Virgin Media.  As I add files over time Crashplan will incrementally update it.  Whilst the files are stored on a NAS which does not have Crashplan installed on it, Crashplan can be pointed at a network share.

## Remote access

I could run a VPN and have remote access to my actual files, but there is anther way.  I have a [Google Music](https://play.google.com/music) account and if you install their desktop software it will upload all of your tracks to their servers and make them available for streaming.  Again, poor Virgin Media, that's the whole lot going up the line, again.  Google Music also plays nicely with my phone

## Recommendations from my collection

Recently I've been introduced to [Rdio](https://rdio.com).  It's an excellent streaming media service, but one of the things I really love about it is the recommendation engine.  When an album finished playing Rdio switches to Autoplay Mode and picks things it things you will like that are like the thing you were playing.  It's driven by [EchoNest](http://echonest.com/), and it's excellent.

By installing the Rdio client and pointing it at my collection I'm telling Rdio that this is stuff I like, so hopefully the recommendations will get even better.

## This seems like a lot of hardwork, why not sure use a single tool?

There are lots of tools out there that should have done a lot of this for me, but nothing worked properly.

I paid for [Tune Up](http://www.tuneupmedia.com/) and it looked like it was doing the job, but then crashed and never recovered.  Money wasted.


## The wrap up

It's taken me ages, but it's a once in a life time job.  Hopefully, clouds willing, I've got access to everything I need.