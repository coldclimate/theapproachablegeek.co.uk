---
kind: article
created_at: "2015-04-04"
title: Always experiment with a slice
---

I've made this mistake more than once, so when I caught myself doing it this time I realised it was time to write about it.

TL;DR When experimenting with something like a new technology try and finish a tiny bit for each layer to ship a small (possibly pointless) example first, so you don't waste a lot of time delivering everything up tot he sticking point.

## Automating infrastructure (four times)

For a new project I decided to build my infrastructure as code rather than hand crafting, something I've been trying to do for the last year. It's not a small project so it made sense to "do it right first time".  There are a range of technologies out there ([Terraform](https://www.terraform.io/), [Ansible](http://www.ansible.com/home), [CloudFormation](https://aws.amazon.com/cloudformation/), BOTO, [Pupppet](https://github.com/puppetlabs/puppetlabs-aws) etc) and so I decided to start with new kid on the block Terraform.

### Terraform
It was lovely to work in, had great teardown type functionality and I was up and running in minutes (unlike Ansible which I'd tried years ago), and after a couple of days I had all my security groups encoded, Elastic Load Balancers being created and all their rules being applied.  Then I hit a snag; Terraform doesn't yet support egress rules on Security Groups, which rules it right out.  It's evolving fast but at that moment that is just not possible.  I could fork, fix and PR, but I'm really not a strong enough coder and tester.  So I parked the work and moved on.

### Ansible (EC2 module)
Next up was Ansible, which I've dabbled in the the past and not found as fast to get started but at least I had a clue what I was doing and I'd done the work to untangle cyclical dependancies in SGs etc whilst working in Terraform.  I quickly replicated what I'd done already and then ran straight into a major problem, Ansible doesn't support VPCs!  As running your entire infrastructure inside a VPC is a pretty smart goal, that was me dead in the water, for the second time.  Ansible EC2 is, under the hood, BOTO, so again unless I fork and PR, it's a no go.

### CloudFormation
With no Puppet experience on the team (and I have none) I did what I should have done and bit the CloudFormation bullet.  CloudFormation covers all the AWS infrastructure API and might well be what AWS uses under the hood but it's big, unwieldy and ugly.  You have to turn your thinking to be "functions as JSON" to get stuff done (which reminded me strangely of Haskell) and on first glance the templates are vile.  However, it was the way forward, and I knew it, so I started turning my Ansible code into  CloudFormation templates.

Several thousand lines of JSON later (yes yes, I should have used a tool like [Troposphere](https://github.com/cloudtools/troposphere) but writing Python to write JSON to drive a command-line to create a Security Group felt like an abstraction too far) I had a VPC and was happily adding security groups to it when I hit the next stopping point. There is a 56k limit on each CloudFormation stack file.  56k!  Thats half a ZX Spectrum 128 from 1985!

I think I had a sense of humour failure at this point.  All of these stopping points were my fault, but they were killing me.  I had wasted vast amounts of time and brain power, been very busy working and delivered nothing.  I knew what the next step was, and it wasn't a big jump, but it was my last chance to get this right.

### The final solution (CloudFormation with Ansible glue)

CloudFormation templates being launched and glued together with Ansible.  Ansible has the ability to capture the outputs of a CloudFormation run and use it as the inputs to the next one, which means you can use a bunch of smaller templates (under 56k) and still not have to hardcode names, id's etc but reuse the info created int he previous step.  It was a quick enough job to convert what I had, reorder it a little to break the final dependancy chain, and finally ship a VPC with Security Groups, Load Balancers, NAT boxes, a VPN endpoint, subnets and instances.  Done, dusted and lesson learnt.

## Cut a slice
When experimenting with something new don't try and deliver all of each layer of the project before moving on.  In this case my layers were each piece of the infrastructure.  I should have looked at the end diagram and tried to build a throw away script which had a VPC with one subnet, with a NAT box, with a single non-trivial Security Group, an ELB and one instance, all of which did absolutely nothing but proved that it was all possible.  I'd have ruled out Terraform in minutes and raw EC2 with Ansible in the first line of code.  I might have hit the 56k limit of CloudFormation but even if I didn't I'd certainly have spotted the need for some form of variable capture.

I think if I'd tried to cut a vertical slice in the outset I'd have probably spent a day experimenting before settling on my final choice or tech stack for this piece of work, not a lot more than that.

## Nothing is new

The glass and furniture industry has the concept of "an apprentice piece".  It's a complete object but made in miniature, because if you can't turn out a perfect chest of draws that's only 30cm high you shouldn't be wasting time on a full size set yet.  I'm going to try and make the goal of my next experiment an apprentice piece of infrastructure, small, perfectly formed, but pointless.
