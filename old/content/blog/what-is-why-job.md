---
kind: article
created_at: "2015-11-1"
title: What is my job?
---

I regularly get asked by friends what I do, and it's a fair enough question.  Tech friends get it easily enough, I say I'm "an ops person" and they ask a few "oh what sort of stuff" type questions.  Non-tech friends pull a face and generally ask "so, you're a programmer?" or "you do computer support", both of which I can only reply "yes, sort of".  I thought I'd take a stab at a better answer.

## The job title
I might as well start at the easy if wrong bit.  I have a nonsense job title, like everybody else in the tech world.  I'm a European Live Service Specialist.  Lets break that down...

#### European
I support a couple of products, one of which is truly global, a couple of which are based in countries outside of Europe and some of which an based in multiple countries.  I'm based in Europe though.

#### Live
Problems in Production come first but I actually spend most of my time working with teams either bringing products live for the first time or working on new live releases.

#### Service
I provide one and I support them so this is basically true.  I'm not part of a product team.

#### Specialist
The last thing I am.  I like to think I'm a [T-shaped person](https://en.wikipedia.org/wiki/T-shaped_skills) with a deep knowledge in the field of Internet enabled service and a broad range of skills ranging from BASH though AWS to Excel.  I can read enough Python, Java and Ruby to debug stuff and know enough command line jibberish to trace a problem right down system calls.  Oh, and I can hold a meeting if needed.


## Things I'm definitely not

### I'm not a designer
Lets just get that out of the way quickly because it comes up frequently.  I'm no web designer and certainly no designer.  I understand enough HTML, CSS and JavaScript to see how it all fits together but I couldn't turn your idea into a functioning design or even turn a flat design into code.  I'm amazed how often I'm asked however.

### I'm not a programmer
I do program, but I'd never sell my skills as a developer these days.  If I'm really honest I was never a great coder (and I've worked with plenty enough to judge).  I can cut code until the cows come home but my abstractions will be a bit ropey and I imagine it will be a pig to test.  Most of the coding I do these days is the digital equivalent of ducttape - gluing bits of commands together to get data out or perform automation of manual tasks or is encoding eg. turning a diagram into something like JSON for CloudFormation.  Lots of the same skills, but not the same thing.

### I'm not a support technician
I've no idea why your printer isn't working.  I can't help you with your network.  I have literally no idea why Word keeps crashing.  My idea of hell is spending all day on the phones walking people through Windows config screens you can't see, and I've a lot of respect for those who can.

## OK, so what do you do?

Analogies are hard in technology.  Nothing really fits well, so take this with a pinch of salt.  There's also lots of medical illusions here but don't for a minute think I'm equating the two industries.


### Part architect

Some of my job is helping design and implement infrastructure for new products or features.  Working out whether something should be split and use a queue, how many copies of a database should there be and how will they communicate, how will the state be stored so that it is available on all application tiers, etc etc.  This is often all on paper (like an architects plan) before the infrastructure is actually built.

### Part builder

Turning an architecture diagram into actual networks, databases instances and the like is often now a matter of write code such as Amazon Web Services [CloudFormation](https://aws.amazon.com/cloudformation/) or [Ansible](http://www.ansible.com/).  The job here is very much taking the plan and building it out completely, then kicking all the tyres and making sure thinks like communication between layers is correct so that all it's waiting for is a deployment of software.

### Part triage nurse

When working with a live system you get a lot of inbound inquiries tickets (and phone calls, Slack messages, emails and walk rounds) along the lines of "There's a problem in live!" and "You must do this urgently".  Step one; work out what the actual problem is, it's scope and whether or not it is real, as fast and accurately as possible. Is it just limited to one person, or access from one machine?  One customer? A finite set of customers?  When did it happen? What did they see? Is it still happening?  Once you've got some clarity of the problem (or lack of it) you can do some quick and dirty investigation to help solve it.  Is the database running a bit hot?  Have we seen a drop in inbound traffic? Are error rates running high?  The aim of the game here is to quickly determine if there's a problem and where it might be before pulling the emergency cord.

### Part surgeon

Sometimes you have to very carefully pick apart a system, modify, replace or remove part of it, and put it all back together again, without stopping anything.  Online services are expected to be available 247 and being down "for scheduled maintenance" is no longer good enough.  This means that operations like upgrading database versions need to be very carefully planned and then executed because they're the equivalent of a heart and lung transplant, you can't just turn everything off, do the work and then turn it all on again.

### Part detective

What happened? How did this happen?  How do we stop it from happening again?  All questions we dread hearing.  It can be very difficult to retrospectively figure out what happened, especially if whatever it was is not going on at the moment.  Dissecting and inspecting log files (often written thousands of lines per second), postulating and investigating circumstances ("if this is the case then we should also see rate X increasing") and really understanding how a system fits together are all skills I use daily.

### Part educator and tour guide

The best way to avoid problems in your live service is to make the knowledge about Production available earlier in the development cycle.  This is much easier in a small company as every techy probably has a log in to the hosting system but even then it's easy to end up developing things that will "never run in live".  By spending time wearing both my architect hat and being something of a tour guide great steps can be made to helping produce a product which doesn't fall at the first hurdle after "runs on a devs machine".  There's so much more I could add here about how the need for this role suggest fundamental flaws in the development process but I imagine it will always be needed in some form.

### Part gardener

Live systems are not "fire and forget", they grow with time, evolve and need constant maintenance, very much like a garden.  Things need pruning and mowing (and eventually this needs automating).  The rhythm and flow of the system evolves and changes over time and this needs reflecting in it's provision and thus capacity.  Response rates and throughput need to be monitored and trended with action being taken, ideally before they grow outside of tolerances (things like indexes being added to database tables for example.)  

## Do you enjoy it?

Hell yeah.  It's often stressful, always challenging and sometimes very frustrating, but it's a great job for a tech focused jack of all trades (and master of some).  The working conditions very hugely with the company and the products you're looking after, but that probably goes for all jobs, and where else could you make your living by writing this sort of gibberish?

  grep "HTTP 1.1\ 504" consolidated.log | awk '{print substr($1,0,17), $4,$5}' | sort | uniq -c | sort -nr | head 100 >> worst_offenders_perminute.txt 







