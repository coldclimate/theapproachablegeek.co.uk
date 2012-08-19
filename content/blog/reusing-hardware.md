---
kind: article
created_at: "2010-11-02"
title: Reusing old hardware to get a webcam online
---
As an afternoon project, I’ve been using some old kit I had in the office to get a webcam up and running pointing at my birdfeeder.  It’s a trial run for a client doing something simalar.  The quality to terrible because it’s an old £6 webcam, but the idea would work.

The kit:

An old Toshiba Tecra laptop, circa 1998.  It has USB ports, but no network interface or wireless.
An unbranded webcam
An Xubuntu install CD
A USB wifi adaptor I got free with the router
Duct-tape
I plugged the webcam and WiFi adaptor into the laptop (currently running Windows 95), popped the XUbuntu CD in it’s drive, and rebooted, removing Windows for ever.  Ubuntu took a while to install, but having the webcam and WiFi plugged in at install time meant the drivers got installed and it happy connected to my internet connection.

Firstly I installed Cheese, which is very handy for debugging the webcam.  Luckily, I quickly got a picture, so I placed the webcam where it could see the birdfeeder, and added a bit of duct tape to hold it in place.  Once that was in place I installed streamer, which lets you capture images from the webcam as still images. Lastly I installed sshfs which lets me access my webhosting securely, as if it was a local disk.  This makes moving the images around a lot easier.

Unfortunately sshfs mounts time out eventually, and I didn’t find a why to solve it, so I ended up replacing the upload mechanism with ssh keyless logins and scp. The trick to making it work was the last addition to this article about ssh-agent

Next it’s time for a bit of automation.  First I knocked up a script which called streamer, takes a picture, adds a timestamp to each image using ImageMagik, replaces the existing current image (imaginatively called current.jpeg) and then copies it to the remote website.  Then I added a crontab entry to call this script every five minutes.  It’s also limited only being on between the hours of 5am and 6pm, because it’s pretty dark otherwise.

I’ve written all the details of how I did this using Dropbox and another old laptop over on coldclimate.co.uk where I blog persoanlly.  All the scripts you need are there too.

Now I have an image file on my web hosting here at The Approachable Geek which is updated every five minutes, showing the feeder.  Hopefully you’ll spot something fun on there! Due to the orientation of the house the late afternoon sun will just about wipe out the picture.

