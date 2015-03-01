---
kind: article
created_at: "2015-03-01"
title: Scaling websites
---

Right off the bet let me be clear, I'm not a scaling expert, not by a long way, but I do spend a lot of time talking to non-technical people about the impacts of technology on their business and recently that's involved some chats about how, when and why they need to consider scaling.  Realising I'd had the same conversation several times I figured I should write it down.

## A rough analogy
Technology analogies are often dreadful, but I've settled on this as the best I can do.  It's leaky, pun intended, but it works at the level of abstraction we're talking about here.

Your website is like a sink with a drain behind it.  Web traffic is like pouring a bucket of water into that sink.  If you trickle it in at a gentle pace, the drain handles it just fine and everything runs smoothly.  This is your website with manageable levels of traffic.

Now, tip the bucket of water in a bit faster and what happens?  The drain can't cope and water starts to back up, filling the sink.  Water you add now takes longer to make it down the drain but it's not all flowing over the top yet so it's a bit crappy but you can cope so long as the sink doesn't fill too quickly.

Now the bucket has been turned into water cannon and it's all piling into your sink.  The drain is doing it's best but it's maxed out.  Soon the sink fills and some of the water is still making it down the drain but most of the rest is failing to be served and is pouring onto the floor.  This is your site under extreme load.

## OK, so what's next?

If you don't deal with the technology behind websites much solving this problem of water pissing all over your floor might look like a matter of throwing more computing power at the problem. "Turn up the dial" as I was once told years ago.  Sadly, much like dealing with your sink, it's a bit more complex than that, but there are some techniques that are easy enough to grasp.  Along the way I'll have to stretch my sink analogy though.

## Vertical scaling

Simply put, vertical scaling is throwing more firepower at the problem, building a wider drain.  More RAM, more CPU, more network capacity.  More of the same.  Vertical scaling in cloud environments is a lot easier than if you have real machines in datacentres.  Enbiggen all the boxes!

## Horizontal scaling

More computers, not bigger computers.  Horizontal scaling is the equivalent of putting more drains into the same sink.  Just like adding more drains it's also a bit more tricky, because the application you are running (the website) might need to understand whats going on across multiple boxes.  Where before everything needed might have been available in memory or on a local disk now that information is on another machine.  Often easily solved, but not to be dismissed out of hand, because it's very difficult to do on the fly.

## Extending the metaphor

Unsurprisingly the technology behind a website is not quite as simple as the pipe behind your drain.  You've probably heard of the three tier architecture, with a presentation layer, a logic layer and a data layer (generally a database).  As websites get more complex this model is getting less common, but new and more diverse architectures are all built on similar mindsets, with groups of machines doing one thing well, glued together with queues or pipes of one kind or another.

To get back to the drain, imagine behind your drain there is a pipe, and that pipe splits off into two or three more drains.  Water pours out of the end of the split pipe and into funnels perched on the top of other pipes.  Some of those pipes are thinner, some of the funnels are bigger, some maybe have those whirly-gig fans in them that whiz round doing something really important and specific (that nobody but the most expert plumber understands).  Each time the current set of pipes splits, that's the end on one layer and we're onto the next one.

Most of the time, as more water flows through, this crazy Heath Robinson affair does just what we want, getting water from the sink to where it needs to go, but as the flow of water increases some bits of this system will get backed up or overflow, heaven forbid the whirly-gig might snap under the pressure and then Bad Things Will Happen (ask the plumber).

## So?  Horizontal or Vertical, which?

Probably both, in different amounts, in different places.  It depends where you're dealing with.  Some tiers will naturally have more capacity than others.  If you make your top drain wider you just move the problem further down the chain.  Maybe the problem actually exists further down the chain and your massive drain is just thundering water down into a drinking straw.  

Why did the idiot plumber put in a drinking straw you ask?  Because to make that bit work, be it serving images, or saving names or whatever else, the drinking straw did the right job and it had scaled up just fine until now.  The correct solution here might be a fatter drink straw (vertical scaling) or a bunch of drinking straws taped together is the right think (horizontal scaling).  In some cases binning the drinking straws and sticking a blender in there instead (re-architecting) is the crazy but right thing to do.  Understandably this last option is not easily done on the fly.

There are lots of other tricks your plumber might try too.  Maybe some of that water that's being poured on you could be better served by another sink and you can reduce the amount raining down on your sink.  This is where tools like CDN (Content Delivery Networks) come in.  Occasionally some of that crazy plumbing could do something like add a huge tank half way down your stack and provide a buffer for the pipes underneath it.  There are many weird and wonderful things that plumbers do.

## So why didn't you just build it right first time?

A question often asked.  How come you guys didn't build this thing to scale?  Well, because that crazy network of pipes that make up your website are reasonably unique, because not all the water being poured on your is the same.

Some of it is syrup which is harder is slower to deal with (large uploads for example).  Some of it is full of frozen peas which will block up your drinking straws (requests which involve a badly through through database access pattern).  Sometimes lots of that water is actually somebody else's sewage and you need to throw it back at them hard and fast.

The volume, nature and shape of your traffic might well change over time.  Your plumber will hopefully have done the best job that he could at the time and your ops guys should have an eye on all the throughput and backlog in your various pipes, but predicting everything in advance is pretty tough.  When your sink was installed did you put in something so wide it could cope with a monsoon being poured down it?


## OMG I've been Slashdotted/BuzzFed/I'm on the front page of the frickin Guardian!
Yes, these things happen.  Somebody posts something about you and suddenly you're getting a hundred or thousand or hundred thousand times your normal traffic.  The bucket of water, which was flowing with vigour because you're doing ok is suddenly Niagra Falls plunging into your basin.  Your site will get slower, viewers will get the dreaded timeout effect and OMG WE'RE DOWN!

These sorts of things are a nightmare to handle and sensible mitigations are only just starting to appear on the market (hello Cloudflare) but they're also rarities (unless you're BuzzFeed and then they are your business model).  Hopefully your site will degrade gracefully if at all, but at that point my drains analogy fails completely.  A story for another day I imagine.

## Surely Technology X will sort all of this, it's Webscale after all.

I am no fan of the silver bullet because very rarely are they all they are sold to be.  Re-implement it all in Go! Switch to MongoDB!  Hire Oracle! Move to Linux!  These may all be credible parts of a solution (yes, even hiring Oracle, sometimes), but no one thing will give you infinite scalability.

I'm a big fan of "the silver shotgun cartridge" solutions. Multiple discrete changes, each one helping to alleviate a specific problem.  That might be a combination of some larger boxes, a small simple cache, offloading to a CDN and removing sessions from all your public facing pages.  Much more difficult to explain and sell up the management chain (if they care about the details).

## OK great I get it, when should I care?

Most of the time, you probably don't need to give a damn, but it's worth keeping an eye on.  Are your response times creeping up?  That's the equivalent of your sink starting to run a bit slowly.  Your traffic volumes are increasing because of the amazing job your social media guru is doing?  Excellent, congratulations, now start looking at what sort of traffic it is.  Maybe you've got lots of free signups that have added thousands of rows to your database only to not pay and bugger off resulting in your paying customers now paying for a slow service.

Staying on top of your day to day running metrics is good business.