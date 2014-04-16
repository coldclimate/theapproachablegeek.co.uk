---
kind: article
created_at: "2014-04-16"
title: Vagrant -  Stale NFS file handle
---

I had an odd error on my Vagrant box the other day which turned out to be dead easy to solve in the end.  Whilst running my standard setup I received

	-bash: ./script.sh: Stale NFS file handle

"Oh cocks" I thought, "'ll have to vagrant destroy and then vagrant up again, and it takes ages".

"But hang on, wasn't I dicking around with the directory on the host machine yesterday?  Yes, yes I was!"

It turned out that that I'd moved the directory that was mounted and then moved it back, hence screweing up the mount.

First, lets see whats mounted...

	vagrant@back$ mount
	/dev/mapper/precise64-root on / type ext4 (rw,errors=remount-ro)
	proc on /proc type proc (rw,noexec,nosuid,nodev)
	sysfs on /sys type sysfs (rw,noexec,nosuid,nodev)
	none on /sys/fs/fuse/connections type fusectl (rw)
	none on /sys/kernel/debug type debugfs (rw)
	none on /sys/kernel/security type securityfs (rw)
	udev on /dev type devtmpfs (rw,mode=0755)
	devpts on /dev/pts type devpts (rw,noexec,nosuid,gid=5,mode=0620)
	tmpfs on /run type tmpfs (rw,noexec,nosuid,size=10%,mode=0755)
	none on /run/lock type tmpfs (rw,noexec,nosuid,nodev,size=5242880)
	none on /run/shm type tmpfs (rw,nosuid,nodev)
	/dev/sda1 on /boot type ext2 (rw)
	rpc_pipefs on /run/rpc_pipefs type rpc_pipefs (rw)
	192.168.101.1:/git/code/master on /code/master type nfs (rw,vers=3,udp,addr=192.168.101.1)
	/vagrant on /vagrant type vboxsf (uid=1000,gid=1000,rw)

Now lets unmount the problem mount (/code/master)

	sudo umount /code/master

Now pop it back

	sudo mount 192.168.101.1:/git/code/master /code/master/

and we're back.  Sometimes its the silly things