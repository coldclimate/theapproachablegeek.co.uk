---
kind: article
created_at: "2014-04-27"
title: Always have a VPN handy
---
I've been doing a bit more onsite work on late and was planning to write up some of the things that I've found handy, however that shall have to wait for another day.  There is one thing that's saved my bacon numerous times however... having a VPN connection account handy.

I use [privateinternetaccess.com](https://privateinternetaccess.com/) but I also hear good things about [vpn.sh](https://vpn.sh/).  At Less than £40 a year if it saves my bacon even once it's paid for itself.  Being able to punch your way across and out of somebodies network, wrapping all you traffic in a layer of encryption is invaluable.

### Add some security

Unsecured wifi used to be everywhere (and wifi without any form of security is wide open with zero knowledge [check out Eavesdrop](http://www.baurhome.net/software/eavesdrop/)).  Assuming you use an encrypted VPN, and that you can get logged into that VPN securely, you are now significantly more secure.  When did I need it: Having to move money with online banking over airport wifi.

### Dodge blocked ports

Whilst staying in a lovely hotel in France I paid for internet access only to discover that everything was blocked.  Port 80 and port 443 (http and https web traffic) were the only wants open.  So no SSH on port 22, thus no work was being done that night.  Step in [privateinternetaccess.com](https://privateinternetaccess.com/) again because with them I could connect over port 443 and then hop on from there. Evening in the office becomes evening in a hotel room (a slight bonus)

### Appear as an outsider

How do you test firewall rules for your corporate network from the inside?  You fire up VPN, now appearing to be outside, and go from there. Easy.

### Reduce the chances of reverse location

When you access a website from your company network there's a reasonable change that they can use your IP address to tell who's been looking at them.  This might actually be a problem, especially if they are a rival (for example).  Your VPN service has it's own IP addresses, and unless your rivals are very committed (and damn good techies) they shouldn't be able to trace you back.

### Change your geolocation

If you need to look like your internet connection is coming from another country, a good VPN service can help.  Choose a termination point in the right location and you can now access geographically locked content (hello quality Olympic coverage), When did I need it:  testing a geographically sensitive piece of code.  Luckily the client in question only needed to test USA, Canada and France, because I've not found a VPN with points of presence in Iran yet.

### Dodge the corporate filters

Sometimes filters on corporate networks can be a bit over zealous, matching on keywords or blocking access to sites you actually need.  VPN traffic is encrypted and no connection is being made (directly) from their system to the destination site.  When did I need it: I needed [nmap](https://nmap.org/), the site was blocked as a "hacking site". 

### Dissociate your IP

If you want to search for something and not have that search connected to you most people fire up an incognito window and off they go.  They does stop your search being associated with your profile with that search engine, but not with your IP address. However, fire up a VPN connection, then an incognito window, and your search for antidepressants or incontinence problems are significantly less likely to be associated with you in the future. When did I need it:  that would be telling

### Access the naughties

Not just porn.  If you're unfortunate enough to live in a country with heavily policed internet connections a VPN, if you can access it, might help you route around it.  I've never needed to do this but chatting to a group of Iranian entrepreneurs a few years ago they relied on it.

### Dodgy the screwed network

Sometimes companies networks are just plain wonky.  DNS config, weird routing, the occasional crappy piece of kit, sometimes it's actually hard to get stuff done, especially if you're the only Linux or Mac user (as a consultant this is fairly common).  Running your traffic out across a VPN doesn't solve all these problems but for a quick fix so you can get on with your job. When did I need it: A "Windows only" company where I couldn't get a stable connection to download a multi-GB file.
