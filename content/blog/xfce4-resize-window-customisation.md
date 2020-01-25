---
kind: article
created_at: "2020-01-25"
title: Making windows more easily resized in XFCE4
---

I've been uing Xubutu for a good few years but recently, for whatever reason, I've been finding resizing windows fiddly.  Using a touchpad or keyboard nubbin, I've been struggling to hit the edge of the window to click and grab.

I was expecting to be able to find a config file somewhere where I could tweak the size of this "grab space" and a little googling led me to the name "resize grip".

Surprisingly, it turns out that it's not a configable value, you have to resize an image.   My theme is Greybird, so here's an ugly hack to make the grippy corner 4x bigger.

'''

 sudo convert /usr/share/themes/Greybird/gtk-2.0/resize_grip.png -resize 80x80 /usr/share/themes/Greybird/gtk-2.0/resize_grip.png
 

'''