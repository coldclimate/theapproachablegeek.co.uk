---
kind: article
created_at: "2015-107-01"
title: An acronym for data jobs
---

Pretty much every job I've worked on has involved large, single run data jobs in one for or another, be they regularly run over night batch jobs, data migrations to support application code deployments (try to avoid this - [read this brilliant article](http://www.brunton-spall.co.uk/post/2014/05/06/database-migrations-done-right/)) or jobs to clean up mistakes in the customer data, and, almost without exception, they've been a source of misery.

Data jobs often don't seem to get the attention and love that regular code does which is a great shame.  They're scary, they're often dangerous, and they scare the pants off those ops people who often end up running them.  I could tell a lot of tales here about the horror shows I've seen but they all boil down to a few scenarios so I present... A Crap Acronym

I believe that all data jobs should FIRST

## (F)eedback
There's nothing worse than kicking off a job and getting.... nothing.  A blinking cursor, for an hour, whilst you panic and end up stracing the damned process in another window to make sure it's not died.  Jobs should

* Tell you wht they are going to do ("Updating 100,000,000 rows")
* Report in when they start doing something ("Starting batch 1,000,000")
* Tell you when they've done that thing ("file6 finished")

## (I)terative
Don't try and do everything in one massive chunk.  Structure your job so that it is working on reasonably sized sets of data at one time, completing them and then moving on.  This makes feedback easier (indeed possible) and leads nicely too...

## (R)erunable
Processes are killed and get killed.  By working from chunks your job can be canned between them and if you've set it up so it can be started again without fuss, so much the better.  Ideally you don't want to have to redo everything again but just pick up where you left off.

## (S)toppable

Sometimes you have to can a job part way through, for example, this job was thought to be ok to run during the working day but after it got started your customers started getting terrible response times and now you've just got to sit it out.  There's nothing worse than being beholden to a process you can't interrupt because it'll leave your system in an untenable state.

## (T)imed

Feedback is great, but it's not important if it's telling you you are 9% of the way through a job which is going to take 47 hours.  Having an idea of how long a batch job is going to run is essential but often missed.  It can be difficult to get an idea of how long things will take because developers often don't have access to production but simple techniques like EXPLAIN and getting counts of rows should allow you to avoid monstrous mistakes.