---
kind: article
created_at: "2013-08-3"
title: SSH access to my Seagate GoFlex
---
Last year I bought a secondhand [Seagate GoFlex 2TB](http://www.amazon.co.uk/gp/product/B003NE5GY0?ie=UTF8&camp=3194&creative=21330&creativeASIN=B003NE5GY0&linkCode=shr&tag=wwwcoldclimat-21&qid=1375521508&sr=8-1&keywords=seagate+goflex+2tb) to use as a second home NAS.  It's got an iTunes server build in and all that sort of stuff, it's a handy bit of kit.

However, the web-based GUI is dreadful and there are a few security problems [described here](http://forums.seagate.com/t5/GoFlex-Net-GoFlex-Home/GoFlex-took-out-my-web-server-and-ssh/m-p/169954).  I'm so much happier with command line access to servers, so with a little bit of judicious Googling, it turns out SSH access is actually quite easy.

You need the product code (written on the bottom of the device, use all caps, replace XXXX-XXXX-XXXX-XXXX) and your username (same as the one you use to log in through the GUI)

	ssh USERNAME_hipserv2_seagateplug_XXXX-XXXX-XXXX-XXXX@YOUR_IP_ADDRESS

And you're in.  If you'd like to hack with your box a bit more lots of the information on the [OpenStora](http://www.openstora.com/wiki/index.php?title=Main_Page) wiki is excellent.  Your milage may vary, and you've certianly broken the warrenty.

