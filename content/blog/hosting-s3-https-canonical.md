---
kind: article
created_at: "2015-01-04"
title: Moving my hosting to provide HTTPs and canonical URLs hosted in Amazon S3 built with Codeship
---

For years I ran a few chunky sized virtual machines from [Bytemark](https://www.bytemark.co.uk/) and hosted everything on them, and great they were too.  Most of the sites I ran were Wordpress backed and thus a LAMP stack was a sensible choice.  Over time I've moved most things to stack file sites or retired those Wordpress installs.  Eventually the cost of the chunky boxes couldn't be justified so I moved to multiple smaller and cheaper [Digital Ocean](https://www.digitalocean.com/) boxes (and they're great for the money too).

However as most of my sites no longer have a database backend it made sense to eventually move them to Amazon's S3 bucket based hosting.  It's insanely cheap (sub £10 a year I estimate for the couple of blogs I run).  Whilst undertaking this move I figured I'd fix a few things along the way and start to practice what I preach a bit more.

## The end goal

* Sites are built with one of the static site generators I'm used to.  In this case I've got both [Nanoc](http://nanoc.ws/) and [Jekyll](http://jekyllrb.com/) based sites
* I can build locally for testing
* Code for the sites hosted either in [Github](https://github.com/) (public repos because I have a free account) or [BitBucket](https://bitbucket.org/) (private repos are free).  I much prefer Github, but private free repos from BitBucket is too good to ignore.
* Built and deployed when I push to the repo automatically.  No more manual deployments.
* One canonical address for each site.  With (or without) www. and .co.uk/.com should all resolve to one address
* Serve over HTTPS, ideally only over HTTPS

## Build and test locally

This turned out to be the easy bit, because I've been doing it for a year or so, however some tidying up was needed.  There are good guides to getting started with Nanoc and Jekyll but I'd ended up in Ruby Version Hell on my old laptop more than once.  Luckily the cat decided to destroy that machine with a large glass of red wine, so I tried to get into some better habits on my new machine.

Each site has it's own Git repo.  In there I built setup a [Vagrant](https://www.vagrantup.com/) box which is a basic Ubuntu box with the right version of Ruby installed and Nanoc/Jekyll + all the various gems needed.  All my required gems are listed in a Gemfile (see [https://github.com/coldclimate/theapproachablegeek.co.uk/blob/master/Gemfile](https://github.com/coldclimate/theapproachablegeek.co.uk/blob/master/Gemfile)) Thus to build on my box I run

    vagrant up #(it's normally up anyway)
    vagrant ssh
    cd /vagrant
    nanoc compile / jekyll build

(At this point I should add I intend to rebuild this setup with a Grunt build process in it to make use of asset pipelining at some point, just not now)

The above commands result in a compiled site (hopefully) in either ./_site or ./output.  At this point I could use nanoc view or jekyll serve within the virtual machine to throw up a webserver and check the content however after having port forwarding in Vagrant both mess me about (Vagrant on Ubuntu, the source of so many of my grumps on Twitter) and port clash I have a faster way of doing it, an alias "webup" on my host machine that runs the tiny Python Webserver on port 8000. This is what I have in my .profile to make this easier

    alias webup='python -m SimpleHTTPServer'

Fire it up, head to http://localhost:8000 and there is my site to check.

All my posts are written in Markdown which is means I'm writing in a familiar environment, in my case [Sublime Text](http://www.sublimetext.com/)

## Github and BitBucket hosting

There are plenty of getting started guides to help here, I'll not duplicate.  There are a couple of things worth noting about public repos on GitHub.

1. Your repo might rank more highly than your actual site in Google.  This has happened a few times for me for the site's name.  Such is life

2. Anybody can fork your repo (why they would want to I've no idea but hey, because Internet) and when they do, it's weird.  It's only happened once for me and they've nuked it since.

3. People can issue Pull Request/open issues etc which is again odd, but sort of cool.  I'm yet to get a PR into my blog but I'm sure it will happen.

## Building with CodeShip

I came across [CodeShip](https://codeship.com) because they sponsored a local meetup with stickers and t-shirts.  It's an online Continuous Integration service with 100 free builds a month which is plenty for all my blog posts.

I signed up with an email address, then authenticated with both GitHub and BitBucket.  The UI has changed recently, but it is easy enough to create a new project and connect it to the Git repo.  Now whenever your repo changes CodeShip will fire up, pull the changes, build, test and deploy.

First the build (or "setup" as CodeShip call it).  Because I list all the gems I need in my Gemfile CodeShip can setup the same environment as my Vagrant box, so my setup steps are as follows

    bundle install # this reads the Gemfile
    nanoc compile #for nanoc
    jekyll build # for jekyll

These steps will do exactly what they did on my local machine and produce a set of rendered HTML files in an output directory.

At this point CodeShip is really set up to run a set of tests, however as yet I've not got any.  Eventually I'd like to bolt on HTML syntax checking, JS unit tests etc.  For the moment.... moving on.

## Deploying

We'll come back to this after having created the S3 Buckets in AWS


## AWS Bucket hosting

I've used Amazon Web Services on and off since it launched and S3 was a very early feature.  When they  launched "hosting from a bucket" lots of people got excited, but it wasn't without it's issues.  HTTPS is a pain without using custom certificates and CloudFront, you need different buckets for www vs. non www.  It's a good setup but it's not without it's issues.

### The buckets

After signing up for [AWS](http://aws.amazon.com/console) and choosing a region to host your stuff in (I went with eu-west-1 which is hosted in Ireland).

First up create a bucket for each and every variant of the URL you'll need.  Most of these will be empty but we need them for routing.  Give them the same name as the domain you'll be routing to it.  In the end for this site I had to create...

* www.theapproachablegeek.co.uk
* theapproachablegeek.co.uk
* www.theapproachablegeek.com
* theapproachablegeek.com

Not pick your canonical domain.  I went with www.theapproachablegeek.co.uk because I struggled to get theapproachablegeek.co.uk to work (I might have now solved this but I've not tested it).

Click on your desired canonical bucket and click Properties.  Tick the option under Static Website Hosting for "Enable website hosting" and set your index page (probably index.html).

Take note of it's bucket name (XXXXXXXXX.s3-website-eu-west-1.amazonaws.com)

![My canonical bucket](/_assets/images/post_content/canonical.png "The canonical bucket")

Now for each other bucket hit Properties and choose "Redirect all requests to another host name", then set this to your canonical domain name ("www.theapproachablegeek.co.uk")

![One of my non-canonical buckets](/_assets/images/post_content/non-canonical.png "One of my non-canonical buckets")

Now whatever is in your canonical bucket will get served up and eventually all the other buckets will route through to it.

### The User

You need to create a User for Codeship to ship as.  Don't be lazy and use your root credentials, they will work but you're giving away access to everything.  First we create the user, then we set some rules so it can only access the canonical bucket.

From the top menu with your user name on it, choose Security credentials.  Then head to Users > Create Users.  Fill in one item on the list and hit "Create".  Once the user is created you get one chance (and one only) to download their credentials.  Make a note of the Key and Secret, you'll need them.

Now click on your fresh shiny new user and under User Policies head for Attach Policy.  This is a JSON document that governs what the user can do.  Choose Custom Policy and paste in this policy, adjusting the bucket name as needed.  Note the two entries.  This policy gives access to do everything with the bucket, you might want to restrict it down to a subset of actions.  

    {
      "Version": "2012-10-17",
      "Statement": [
        {
          "Effect": "Allow",
          "Action": "s3:*",
          "Resource": ["arn:aws:s3:::www.theapproachablegeek.co.uk",
            "arn:aws:s3:::www.theapproachablegeek.co.uk/*"]
        }
      ]
    }

## The deploy (back in CodeShip)

If your build passes, CodeShip can automatically deploy for you.  There's an easy integration for S3, just fill in the details (Key, Secret, bucket name, region).  Finally set "ACL: public-read" and you should be good to go.  To test it you can either push a new commit and force a fresh build or click the refresh icon next to the last build.  Hopefully you could see a build of your site in your canonical bucket.  Check that it's accessible by using the raw bucket address http://XXXXXXXXX.s3-website-eu-west-1.amazonaws.com

![Rebuilding the project](/_assets/images/post_content/build_refresh.png "Rebuilding the project")

## So where are we so far...

* Code is building locally 
* Code is hosted in a remote repo
* Codeship is hooked into that repo and building
* The build is being pushed to an S3 bucket
* The bucket is setup for hosting
* A bunch of other buckets are setup to redirect to this bucket (you can now test this too - just use their XXXXXXXXX.s3-website-eu-west-1.amazonaws.com bucket names and you should end up at your canonical address even if it's not working)

## Using CloudFlare to provide DNS routing

I buy all my domain names through [I Want My Name](https://iwantmyname.com/) and up until now I've not had a need for another DNS provider however here is where we hit one of the pains in the neck of S3 hosting.  Normally you'd have your DNS record set up so that everything ends up at your webserver by IP address and then sort it out with Apache/Nginx etc.  Sadly to point to an S3 bucket you need to use a CNAME and up until now there's not been a good way to set a CNAME on the route domain (the non-www's address).  Some argue there's still not a good way, but [CloudFlare](https://www.cloudflare.com) provide a way, which is good enough for me.  If you're using Amazons R53 you can also do this with Amazon's own DNS hack.

When you sign up for CloudFlare you don't need to pick a free policy or a paid one, you can do it per domain name, which is a nice feature.  We can use the free tier for all of this luckily.

I stepped though adding my domain names and CloudFlare was painless enough and they did a great job of picking up all my existing DNS entries.  I then set my nameservers at the I Want My Name end to point to CloudFlare and then we're all set to sort out the routing.

Head to your DNS settings for each domain set each combination of www and non-www to use a CNAME to point to your appropriate AWS S3 Bucket.  When you set the root domain (where you set the subdomain to @) CloudFlare will warn you about [CNAME Flattening](https://support.cloudflare.com/hc/en-us/articles/200169056-CNAME-Flattening-RFC-compliant-support-for-CNAME-at-the-root).

![CNAME'ing my domains](/_assets/images/post_content/dns-cname.png "CNAME'ing my domains")

Once you clear your cache and potentially wait 24 hours for DNS propagation, you can test that everything is working over HTTP.  Either type each variant URL into the browser and check that you get redirected to the right place.  If you're a command line fan you can also test that way, which can help with browser cache issues too.

    curl -I http://theapproachablegeek.com  ##  returns a 301 to Location: http://www.theapproachablegeek.co.uk/
    curl -I http://www.theapproachablegeek.com  ##  returns a 301 to Location: http://www.theapproachablegeek.co.uk/
    curl -I http://theapproachablegeek.co.uk  ##  returns a 301 to Location: http://www.theapproachablegeek.co.uk/
    curl -I http://theapproachablegeek.co.uk  ##  returns a 200

Game on, we're now serving the site over four domains correctly.

## Forcing HTTPS 

CloudFlare have an amazing (free!) service to allow you to serve your sites correctly over HTTPS.  It'll actually be running now if you check your site over https://

However, I firmly believe that the more of the web that  is running over HTTPS the better the world will be, so I now serve even my noodle dish recipes over HTTPS.  We do this in CloudFlare using their PageRules.  Head under there for each domain and add a rule that redirects all HTTP traffic to HTTPS

![Forcing HTTPS](/_assets/images/post_content/http.png "Forcing HTTPS")
![How it all hangs together](/_assets/images/post_content/domain_flow.png "How it all hangs together")
## All done!

There's a few bits and pieces I could clean up here (specifically I think this could all be done with one S3 bucket), but maybe that's for another day.  I'll keep a tab on costs and update here after a few months.





