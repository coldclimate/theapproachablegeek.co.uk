---
kind: article
created_at: "2011-05-21"
title: Making timelapse films with open source firmware and cheap hardware
---
I fell in love with timelapse films as a child. There really is something magic about watching plants growing in front of your eyes, or seeing landscapes grow and evolve right in front of you. Creating timelapse films used to be the preserve of the professionals with hugely expensive kit, but no longer.

I’ve been making use of an amazing open source project called Canon Hardware Development Kit I’ve been producing timelapse films for the last couple of months. CHDK is installed to a memorycard and replaces the normal software on a range of cheap Canon cameras, unlocking a range of features that are (at best) only available on the top of the range Canon kit, or completely new.

Installing CHDK is a touch fiddly, but the instructions are pretty good and if you’re using Windows or Mac there are installer such as cardtricks which simply the process.

CHDK does not run on all cameras, not even all Canon cameras, so check the website carefully before spending money. I have had success with a Canon A480 from Argos (which was on offer). You will also need an external powersupply which are fearsomely expensive from Canon, however an unofficial one from Ebay was only £15.

CHDKs biggest feature is that you can write scripts for the camera, and it will automatically process. In this case I got a timelapse script which takes a picture every minute and saves it. Using a nice large memorycard (4GB) you have plenty of space for thousands of photos.

I’ve had my camera installed in a range of great locations in the North East for the last month, mostly thanks to friends securing me access to places I’d never have got into without them. Installations are mostly in the MacGyver style, using plastic bags and ductape to make everything waterproof and less likely to blow away.

Once you get the photos back it’s just a matter of compiling them down into a film, for which there are lots of options. I’m using mencoder, which is a bit fiddly but has lots of options.

Finally, the films go up to my video hoster of choice, Vimeo.

