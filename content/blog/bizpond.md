---
kind: article
created_at: "2010-07-14"
title: Technical advice for Bizpond.co.uk
---
Bizpond.co.uk is a simple idea to help less technical businesses find benefit from services such as Twitter and the communities that form around them.

Bizpond went from concept to launch in three months, and was a collaborative project between Stick Theory, Twisted Studios and The Approachable Geek, with suport from PNE Group and Women Into The Network. I was involved to help smooth over the technical project management and to help sort out requirements and technical implementation problems.
Working with Di Gates from Stick Theory I was able to help turn the projects requirements list into a possible list of technologies that could be made use of, and throughout the project I’ve been on hand to translate between techies and other teams. Post launch of Bizpond I’ve been on hand to try and get to the bottom of some fiddly glitches.
One of the aims of Bizpond was to make use of as many external services as possible to minimise the custom code being created. Bolting in external services is never as easy as non-technical people imagine, but it can give great benefits over “rolling your own”. Some of the services that Bizpond is making use of include…
bit.ly : Turns long URLs into short ones suitable for sharing and adds tracking. When Bizpond tweets out a post it includes a shorterned link (for example http://bit.ly/aIeaWo). When this link is clicked it is recorded and the Bizpond team can track this by adding a + to the end of the address http://bit.ly/aIeaWo+


JanRain Engage : Makes integrating the code with Twitter easier for developers, and could be used in the future to allow users to log in using Twitter instead of a custom username and password.
getsatisfaction.com : is used to provide a public viewable feedback mechanism, and only requires a couple of lines of code to be added to the site. Doing your customer support in the public is scary for many, but encourages far better levels of service and customer engagement.
Google Analytics : is used to track not only page views but other key performance indicators. Adding Analytics to a website is trivial, but without some additional configuration and code it will not necessarily track the things that you need it to. Bizpond needed to know how many of it’s notices with being replied to, and how many were being shared, both of which would not have been tracked by default. The Approachable Geek was able to match business requirements to code hooks, as well as deliver the on site training for the administrator on how to extract the gems from the wealth of info that GA provides.