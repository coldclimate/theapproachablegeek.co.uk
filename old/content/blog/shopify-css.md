---
kind: article
created_at: "2011-08-26"
title: An oddity when working with JavaScript in Shopify themes
---
Recently I’ve been doing quite a bit of work turning packs of HTML and CSS into [Shopify](http://www.shopify.com/) themes.  Shopify is an amazing “Shop as a Service” website which makes it really easy to get your online shop up and running quickly letting Shopify handle all the hard bits (scaling, the CMS, payments etc).

What makes Shopify really impressive is you can write (or buy) themes for your shop which are extreamly customisable.  The functional logical of the templates if written in a language called Liquid.  At first [Liquid](http://www.liquidmarkup.org/) looks clunky but it’s actually very powerful when used in combination with Shopify’s available data.

Shopify also let you add into the theme any other assets you might need, css, images, JavaScript etc. and this lead me to a frustrating problem which it seems worth writing up.  Looking back it’s screamingly obvious, but at the time it was far from it.

I was trying add a [lightbox](http://www.lokeshdhakar.com/projects/lightbox2/) to a product, a simple enough problem normally.  Because the site was already using jquery I chose a jquery based [lightbox](http://leandrovieira.com/projects/jquery/lightbox/) rather than introduce yet another set of JS libraries.  I added the JS files, the css and the image assets to the theme, bolted on the right selectors etc and it was up and running.  Clicking on the thumbnail caused a nice big image to be overlaid.

The problem was that the “Next” and “Close” buttons had broken images.  When you upload assets to Shopify it has no support for sub-directories in the assets directory so the paths of “../images/close_label.gif” needed modifying.  I tried “close_label.gif”, but that failed too, with the generated path being that of the page we were on, not the location of the JS file.  Very frustrating.

The problem was that I needed to get Liquid to render that image path so that it would take on the location as specified by Shopify.  JS assets however, unlike .liquid files, are not parsed, and so the {{ ‘close_label.gif’ | asset_url }} tag is never replaced.  I tried every dirty hack i could think of but nothing worked.

Finally, after swapping out jquery-lightbox for slimbox it worked !  Why?  Because [Slimbox](http://www.digitalia.be/software/slimbox2) uses CSS properly to style to pop-over rather than having the JS write the images into the DOM.  Proper separation of display and content wins the day.  CSS taken on the relative paths to the images based on it’s location, rather than the location of the page as the JS method caused.

The moral of the story, separation of presentation and content is important.