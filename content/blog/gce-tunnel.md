---
kind: article
created_at: "2013-04-07"
title: How to set up an SSH tunnel with Google Compute Engine
---
Recently I've been doing a tonne of work with [Google Compute Engine](https://cloud.google.com/products/compute-engine), Google's equivalent of Amazon EC2 and S3.  It's good, very good, and I'll write up more about how we're using it at a later date.

All interactions with your Instances (boxes) is through the gcutil program, which is very neat and clean, but also (behind the scenes) basically SSH and the GCE REST API, so pushing and pulling filesis really just scp etc.

One thing gcutil does not natively support is tunneling, but luckily you can spot all the bits you need and reproduce is using bog standed SSH.

    ssh -L 12345:localhost:15672 -o UserKnownHostsFile=/dev/null -o CheckHostIP=no -o StrictHostKeyChecking=no -i ~/.ssh/google_compute_engine -A -p 22 ubuntu@1.2.3.4

 This produces a tunnel from your local machine to the remote Instance (1.2.3.4), running a tunnel from localhost port 12345 to the remote host port 15672 (RabbitMQ management console in our case).

 If you need to find the IP address of your Instance or the location of your ssh keys, jump onto your Instance using gcutil and you'll see these echod to screen.
