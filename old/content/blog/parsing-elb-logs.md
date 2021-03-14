---
kind: article
created_at: "2015-11-14"
title: Parsing AWS Elastic Load Balancer log on the command line for fun and profit
---

Amazon Web Services Elastic Load Balancers are excellent bits of kit and one of the mot useful things they have is that you can enable logging easily.  Every request that comes through gets a tonne of information logged about it and the log fires are dropped into an S3 bucket every 5 minutes (or more, this is configurable).

Because of the time delay, monitoring ELB logs for real-time alerting is not something I've experimented with, but processing logs to figure out what went on is something I've spent a lot of time on recently.  It's also a great excuse to glue some command line tools together.

# Getting hold of the logs

First step, pulling down the logs.  These things are often huge and if you've got multiple ELBs it's a pain.  Luckily my colleague John wrote the following neat little one liner to pull the logs for the current hour and filter them by name.

    aws --profile YOUR-PROFILE s3 cp s3://YOUR-BUCKET/PREFIX/(date +%Y)"/"$(date +%m)"/"$(date +%d)"/" . --recursive --exclude '*' --include *YOUR-FILTER*$(date -u +*%Y%m%dT%H*)


>YOUR-PROFILE You should totally use [AWS profiles](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_use_switch-role-ec2_instance-profiles.html)
>YOUR-BUCKET s3://example-bucket
>PREFIX Whatever directory your logs are in
>YOUR-FILTER Something to match the logs you're interested in

This gets you a bunch of .log files.  These are often most easily dealt with as one big log file so cat them together and sort them (because each lines starts with a timestamp this works fine).  I normally bin the original log files at this point.

    cat * log >> single.log && cat single.log | sort >> single.txt && rm *.log

Now you have a single (possibly chunky) file to work with.  Here's an example of a row

> 2015-11-14T08:55:02.614276Z elb-name 217.13.151.25:14990 10.181.281.191:80 0.000041 0.07498 0.000038 201 201 56 305 "POST https://example.com:443/path/to/something/file HTTP/1.1" "-" ECDHE-RSA-AES128

There's a tonne of entries there, best is to [read the docs](https://docs.aws.amazon.com/ElasticLoadBalancing/latest/DeveloperGuide/access-log-collection.html)

# What you shouldn't bother parsing out

CloudWatch will give you a tonne of information about your ELBs and it's not worth you pulling logs, parsing them and doing it yourself.  Check out [the available metrics](https://docs.aws.amazon.com/ElasticLoadBalancing/latest/DeveloperGuide/elb-cloudwatch-metrics.html) before you start.  Things such as average response times and total request counts over a minute are much more easily pulled from Cloudwatch.

# Good things at your fingertips

So what can you get out of these logs and how?  Here's a few examples, with some reverse engineering to help explain some of the awk gibberish.


## How many of each status code
CloudWatch will give you counts of 2xx, 3xx, 4xx and 5xx status codes but sometimes it's important to get the finer detail because 401s and 403s are very different.

The output from this can easily be pulled into Excel to graph or analyse with a pivot table or pushed through something else on the command line.

    cat single.txt | awk '{print substr($1,0,16), $8}' | sort | uniq -c | awk '{print $2,$3, $1}'

    2015-11-14T08:55 200 7
    2015-11-14T08:55 201 2
    2015-11-14T08:55 204 1

Breaking each bit down:

### cat single.txt 
Read the giant file line by line and push it's output onto the next command

### awk '{print substr($1,0,16), $8}'

We want to print out a substring to the timestamp to get the time to minute, and the HTTP status code that we returned.  The status code is easy, it's the 8th column (awk splits by one or more spaces by default), the timestamp is a little trickier because it's accurate down to the milli second (2015-11-14T08:55:02.614276Z) so we're going to slice out the first 16 characters to give us 2015-11-14T08:55

### sort | uniq -c

To get a unique count of each line (and thus how many of each status code happened in that minute) we first sort the list (probably not needed if you've sorted your original input list) and then push into "uniq count"

This gives us the output of 

    7 2015-11-14T08:55 200
    2 2015-11-14T08:55 201
    1 2015-11-14T08:55 204

Which is useful enough, but having the counts on the end makes life easier in Excel and others because it is likely that the timestamp is the key to the data.

### awk '{print $2,$3, $1}'

Awk to the rescue - print the columns in a different order.  

## Find all the rows where a specific status code was returned

    cat single.txt | awk '$8 =="500" {print $0}'

Column 8 is the HTTPS status code that the ELB returned to the client.  Here we use Awk's "implicit if" type mechanism to only print the whole row ($0) if the 8th column is an exact match to "500" eg. server error

## Find all rows with a pattern match on the status code

    cat single.txt | awk '$8 ~ "5.." {print $0}'

 Very similar to the command above but using the unusually syntactic ~ to mean "pattern match".  Here we're matching column 8 with " 5 anything anything"

 This is really handy when CloudWatch tells you there's a slew of 5xx errors, and you need to know exactly what they were

### Which IP addresses are hitting me most per minute

 This is the sort of thing that [Go Access](http://goaccess.io/) and other such tools are excellent for (here's the formatting for [getting GoAcess to parse ELB logs](https://twitter.com/goaccess/status/447037494299607040) ).  Like the status codes per minute code this is perfect for pulling into other tools.

     cat single.txt | awk '{print substr($1,0,16), substr($3,0,index($3,":")-1)}' | sort | uniq -c | awk '{print $2,$3, $1}'


 The last few statements ( sort, uniq -c , awk '{print $2,$3, $1}') work exactly as above - sort, find the unique count, jumble the columns around a bit.

 Breaking down the more complex Awk:
 
### print substr($1,0,16)
 
 Print the first 16 characters of the 1st column

### substr($3,0,index($3,":")-1)

This uses a nested command.  First the substring says "from the 3rd column, start at place 0 and print out the number of characters equal to the result of the index function"

The index function index($3,":") says "in the text of the 3rd column find the location of the colon".  We then knock off 1 from this value thus turning 217.13.151.25:14990 into 217.13.151.25 rather than 217.13.151.25:

## Show me the rows where the ELB did not return the same status code that the backend server handed it

There are lots of reasons for this, including the backend server not returning a value.  Such a pain to debug.

    cat single.txt | awk '$9 != $8 {print $0}'

Print every line where the two status codes don't match

## Which URLs are being hammered

Another likely candidate for a pre-build analytics tool except where your logs could do with some pre-parsing to get rid of GUIDs and such which make finding groups of URLs a pain.  Here I'm removing all GUIDs of the form 8-4-4-4-12, even when there are multiple in the URL (id and signing for example)

    Sample input URL: https://example.com:443/something/uetdgfbc-jepp-rgtd-eycv-hgtdnmvyallo/delete/_GUID_

    cat single.txt | awk '{print substr($12,2,length($12)), $13}'| sed 's/........-....-....-....-............/_GUID_/g' | sort | uniq -c | awk '{print $2,$3, $1}'

    DELETE https://example.com:443/something/_GUID_/delete/_GUID_ 2
    POST https://example.com:443/something/_GUID_/create/ 20
    POST https://example.com:443/something/_GUID_/update/_GUID_ 1

Breaking that down a bit...

### substr($12,2,length($12))

Awk doesn't by default respect wrapped strings so our 12th column was actually "POST or "DELETE thus I substringed off from the 2nd character to the end of the string (found with "length")

### sed 's/........-....-....-....-............/_GUID_/g'

There is probably a much smarter was to do this, but I'm lazy and this is very grokkable even when tired.  sed is replacing any groups which match 8 characters-4 characters-4 characters-4 characters-12 characters with "_GUID_"

The rest of the commands sort, count unique values and juggle columns as above.


# How to experiment on these

When I first started trying to parse ELB logs I wasted a lot of time.  Here are the lessons I learned along the way.

## Run on a subset first

 Instead of catting the whole file into your experiment, use "head single.txt" to begin with, running your test on the first 10 lines.  If you need to use lines which contain something specific then used 
     grep "thing of interest" single.txt | head 

This gives you 10 lines of interest

## bBild it in bits

Don't try and build the whole thing in one go.  Build the first bit (the right lines for example), then bolt on the next bit (group and sort maybe) and keep expanding until you're at your destination

## Filter first

Both grep and awk's ~ and == mechanisms give you powerful ways to cut down the amount of data you're dealing with.  The less you have to deal with the faster all following commands are.

## Test pattern matches with ones that you know will work first

This bit me so many times.  I wrote awk statements to check for 500 statuses, and found none, happy days.  I was an idiot, and a simple grep showed me I was wrong.  Better to have tested my awk on the more common 200 status, make sure it worked, and then simply swap 200 for 500.

## Dump whole values, then cut down with substr and friends

When writing the "calls per IP per minute" commands I got really hung up on the getting the IP address without it's :port on the end.  I ended up stopping trying to slice up the string, finished the rest of the chain of commands, and then discovered the index command in awk.

# Isn't this just a massive circle jerk - surely there are tools for this?

There might be, and it may be, but I've not found something that covers all of these scenarios.  It is very empowering an powerful to be able to quickly glue some simple commands together and get out information for a very specific question such as "which accounts were affected by the glitch in Redis" or "Is something going on that could be affecting latency"
