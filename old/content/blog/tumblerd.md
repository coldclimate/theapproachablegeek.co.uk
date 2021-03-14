---
kind: article
created_at: "2016-02-27"
title: tumblerd process eating my machine alive
---

I blanked and reinstalled my work-a-day laptop a week ago (more on this another day) and I noticed it was suddenly very slow occationally, but it would clean itself up so I didn't get round to debugging it.  Tonight however it wasn't going away so I started debugging it.

First step - running *top* and spotting a process called *tumblerd* eating a tonne of memory and CPU.  A bit of googling showed up that this process helps build thumbnails.  Why was it going bonkers?  Breaking out a bit of *lsof* showed the process was accessing a handful of large video files I had transfering at the time.  

Why was it building thumbnails of these files which I wasn't yet accessing?  Because I'd left a window open with the file listing in it, so as these files were being updated tumberd was trying to update thumbnails continiously.  Closing the window sped my machine right up again.

Along the way I came across this great article about [stopping and removing tublerd on xfce4](https://miteshjlinuxtips.wordpress.com/2012/11/16/stopping-tumblerd-in-xfce/).
