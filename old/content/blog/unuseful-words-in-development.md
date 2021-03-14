---
kind: article
created_at: "2013-12-08"
title: Less than useful words when developing
---

When discussing code it's all to easy to use words and language which express your feelings but add nothing to everybody's understanding of the situation.  Over the last few weeks I've been trying to catch and correct myself (we've a new team member and there's a lot of our stack to learn so it felt important)

> *TL;DR* Everything you can do to swap from the emotive to the constructive will reduce tension and reworking whilst improving understanding and learning.  It's not rocket science now that I've written it down.

# "The current structure is all rubbish"

This was a fairly small data structure we had running in live that was working just fine, but needed re-factoring.  It had been fit for purpose when it was first created but over time we'd seen one of the values grow uncontrollably (not exponentially).  Whilst correcting this we could make a few other adjustments meaning that by the end of this re-factor the whole structure will have changed.  Thus it was not all rubbish, but it did all need to change.

# "It needs to work properly"

What was said

> It just needs to work properly

What was meant

> * This should be an abstract and a couple of concrete implementations.
> * They should be unit tested (to a coverage of over 80% or so).
> * It should only call the persistence calls once rather than after every stage.

Each team has it's own culture and standards, and without being explicit about them (and writing them down), a new team member it's going to know what is right and acceptable.  Making this clear before code is committed is much more efficient that during code review.

# "There's bunch of chaff in here"

All code caries a weight of debt with of out-dated or crufty lines which might well work but are no longer "how we do things round here".  When you're getting up to speed with a large code base (or even a small one), without knowing what's wrong with a specific file it can be difficult to pick through what's good code and what's not.

# "It's sub-optimal"

Lots of code it, the question it what is sub-optimal.  Does it perform horribly, which would be a bad thing but does it need sorting right now?  Does it use design patterns that we don't use elsewhere in the code base (which is annoying and increased the cognitive ramp up of getting to know a code base) but work?

# "The whole thing is shit"

And there are definitely times when this is true (hopefully for a single class for sub-system), but when you start poking through a code base and you'v got "it's all shit" in the back of your head when you're reading code you're going to be in the wrong frame of mind.  Every glitch, every typo, every slightly crappy function is going to re-enforce this thought.

# Language is hard

Writing this I've realised that all of the situations where my language hasn't been constructive are where there are problems in our code base.  Like any large code base we've got out problems, and they irritate all of us, but unless we're specific about what is wrong and get away from generalisations, they're harder to solve and more demoralising than they have to be.  Maybe specificity is the key to happiness.