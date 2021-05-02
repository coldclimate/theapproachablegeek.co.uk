---
date: "2021-05-01"
title: Write things down
tags: ["culture"]
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

I feel ridiculous writing this, but the last year especially has made me believe more and more that the key to getting things done as a group, is writing things down.  If you're working solo, doing your own thing, then you can probably get away with writing very little down, but if you're going to be part of a team (and who isn't, when you get down to it), writing stuff down is key.  To be honest, even working solo, writing a daily TODO list (which I'll probably write up some time) is amazingly helpful.

Why did I mention 2020?  Working remotely from everybody else is intense, the good stuff is great (2 hours a day more in my life, massive savings on commuting and eating, lunch with my parter most days, seeing the sunrise with a coffee, the list goes on), and the lows are *super* low.  Endless video calls, loneliness, impostor syndrome really kicking in, realising how bad your home office setup really is (if you're lucky enough to have one), the list is long but my biggest bugbear is poor communication leading to frustration, wasted work and resentment on all sides.

So much communication is done real-time, and it gets lost in the ether.  It's much easier to "hop on a call" sometimes, especially for me at the end of the day where I'm struggling to write whole sentences in an IM tool, but once you hang up (after waving, natch), what you talked about is gone.

So, in 2021, I'm doubling down of writing stuff down.  I'll still ring folks and go to meetings, but I'm going to level up my writing.  Ironically, this is not a brilliantly well structured piece of writing, gotta start somewhere though right?


## De-synchronization...


### ...Of meetings

I'm a great believer in doing all you can to make work asynchronous, so people can work at a time that is best for them (because they might be in a different timezone) and so they are not stuck waiting for something before continuing (which seems obvious).

Meetings are the most time sucking mechanism of forced synchronization that we have in businesses today.  Everybody has to be there, at the exact same time, for the length of the meeting, sometimes passively.  I'll not dive into the culture of meetings, thats for another post, and the first commenter to mention "well just leave a bad meeting" gets a gentle reminder of the level of privilege that requires.

It's acceptable to record something like an all hands meeting, so that the few who couldn't be there at the time can sit though a 60 minute video later (though I'd still prefer a transcript or better yet a comprehensive set of notes) but it's not acceptable to record every 30 minute meeting and send the link out "as notes".  It's a waste of time, nobody is going to sit though it and if you're doing it to "document the discussion" you're lying to yourself.

Meetings should have an agenda (what we plan to talk about) and minutes (what we decided and what actions we're taking).  These don't need to be heavy duty, you don't need to transcribe the whole thing, just write these 2 lists, and made them clear if you're expecting somebody to do something, then send them out to everybody you invited to the meeting.  We're aiming for clarity here, not who said what and who didn't agree at the time.

Reasonably frequently if I can't attend a meeting I'll make it as "tentative" (thanks Office 365) "for the notes".  That way when the meeting is finished the organiser can hit reply-all and even though I wasn't there I'll understand what's going to happen and if I am expected to do anything.


### ...Of discussions

A few months ago I ran across the concept of those who "talk to think" and those who "think to talk", possibly in [Just Listen](https://www.amazon.co.uk/Just-Listen-Discover-Getting-Absolutely/dp/0814436471?dchild=1&keywords=just+listen&qid=1619872389&sr=8-1&linkCode=ll1&tag=hhkudac-21&linkId=33b4855dc2bcafeda2bf6cd338bac0d5&language=en_GB&ref_=as_li_ss_tl) in the context of meetings.  I've found I'm somebody who needs to "write to thing".  Creating big rambling text files helps me get my thoughts in order.  If I do this on a wiki page, open inside the company, people can chip in and correct me, or follow along out of interest or at least know that somebody is thinking about whatever that subject is.

However, these "brain dump" pages have their pitfalls.  They are not a plan.  They're not brilliantly structured and if you're not careful they can be accidentally taken as gospel, causing chaos.  To help mitigate that, I generally not have a banner across the top, something along the lines of...

``` I'm thinking out loud here, don't take any heed of this, but if you'd like to comment or amend, please, dive in. ```

Once I've got my thoughts straightened out it's then easy to take this page and make it into something that is sharable.  I tend to push all the existing content down to the bottom under a new header "Working notes" and then write above it.  People can then dive in and read, comment (in-line comment boxes are great for this), edit, amend, etc.  All of the discussion happens on the page which will become the document, and so it's all there if people want to read it later, when they uncover the doc.

If needed, that page can become the centre of a meeting, if you really have to make is syncronous, but in the meantime it's self-contained and easily "pick upable" by anybody who's interested.

## Making technical discussions more inclusive

I am blessed that English has been the default language of all the businesses I work in, but very often it's the 2nd, 3rd or 5th language that somebody I work with is working in.  Being embarrassingly monolingual, I don't know this for sure, but I'm 99% sure that if you're working outside of your mother tongue there is less change of you missing something if you're reading it rather than hearing it on a call.

So whilst I'm only able to work in English, I am a bit deaf.  I regularly use subtitles because they backup what I'm hearing.  A written technical discussion is often a lot more approachable for me that a slightly shouty call.

One note here is that people who as shy/nervous/fearful of the repercussions of saying something are even less likely to comment on a document, edit a wiki page or even shout up in a group channel, than they are of saying something up in a meeting.  If you don't work to foster a genuine culture of safety, they will stay quiet.  I try to lead by example and I'll happily leave a clarifying comment in a page, even if I'm kinda sure of the answer, because if I was wondering it, somebody else might be too.

## Clarity and accuracy

If I have to, I'll always choose Clarity over Accuracy in my communications.  When there are 7 corner cases and scenarios, this is difficult to get across in a call.  However, if you're writing stuff down, you can do this, and without writing a 20 minute piece; summerise at the top, include the details below for those who might need it.  Hell, you can even though in a diagram.



## History

My weapon of choice will nearly always be a wiki.  Lots of folks will say that a wiki is where "content goes to die", and in many cases they are not wrong, but where wiki has a huge benefit over other documents is that there is a history that is easily accessible and it's even got commit messages if you choose write them.  Yes, I'd love to do it all with git and Markdown, but I've tried doing that in a technical company with technical people but it just doesn't work outside of people who work with those tools day in day out.  A wiki is wysiwyg, familiar and has all the bonuses of git+markdown+static site compiler+CD.

Lots of companies aspire to introduce [ADRs](https://adr.github.io/), and eventually I hope to as well, but in the meantime I've got a tool that will at least tell me who made a change, and maybe why.  it's definitely tell me what was there before and in the worst case I can drop them a line with a visual diff and ask them to tell me about why we're not planning to do what we all last talked about.

## In summary 

I'm 100% not saying that businesses should switch to being some form of text-only based discussion.  As somebody wise once said (attribution needed) "don't try to write better tickets, have better discussions", and I completely agree, but at the end of that discussion, if you need to, write down the salient and actionable points.  If you can't have that conversation in realtime, and maybe even if you can, try doing it in written form.
