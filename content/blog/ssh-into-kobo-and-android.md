---
date: "2026-02-15"
title: How to SSH into your Kobo ereader and android phone
tags: ["ssh"]
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

I had a big post about why I was doing this part written, I felt silly and nuked it, and then I realised that somebody else might want to do one of these things, so I should share how I ended up doing it.

My motivation: be able to sync files from two closed-source devices I own over ssh for ease.


# Kobo eReader
It's a good little device and unlocking ssh was pretty easy.

1. Mount it over USB
2. Show hidden files (command+shift+fullstop on a Mac)
3. Head into the .kobo directory
4. Rename the file "ssh-disabled" to "ssh-enabled"
5. Reboot your Kobo

That files actually contains the instructions to do this (well done Kobo!)

> To enable ssh:
> - Rename this file to ssh-enabled
> - Reboot the device
> - Connect via: ssh root@<device_ip>

The first time you connect you'll be asked to set a password.

Now you can happily ssh in, rsync books back and forth and mess on until your heart is content, as you should be able to with a device you own.

# Android phone

I mostly want ssh for syncing files, but I'm sure there's other reasons.  I have a OnePlus 12, but I imagine this works on other devices too.


1. Install Termux - I using the one in the Playstore
2. Open it and you've got a command line!
3. Update the package store `pkg update`
4. Give Termux access to your storage `termux-setup-storage` - I had to click permissions approvals bits here
5. Install OpenSSH on the phone `pkg install openssh`
6. Grab the IP address of your phone (I'm looking for the local address from my wifi network that starts 192.etc.etc) `ifconfig`
7. Grab the username of the user this is running as `whoami`
8. Set a password for this user `passwd`
9. Start the SSH deamon `sshd`
10. From my laptop it took a while to then get in because it turns out SSH on my phone was not running on port 22 and I couldn't be arsed to figure out why, however I could now connect!  `ssh -p u0_REDACTED192.168.x.x`
11. Success!  Have a poke about to figure out the file system layout.
12. Now I can rsync files across way faster with `rsync -avz -e 'ssh -p 8022' u0_redacted@192.168.x.x:/data/data/com.termux/files/home/storage/dcim/Camera/ .`


# What a faff

Yes, this is all possible, and all credit to Kobo for making it possible and easy.   Access to your devices is a right.