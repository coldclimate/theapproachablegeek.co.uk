#!/bin/bash

echo "deb http://archive.canonical.com/ precise partner" | sudo tee -a /etc/apt/sources.list
echo "deb http://nginx.org/packages/ubuntu/ precise nginx" | sudo tee -a /etc/apt/sources.list
echo "deb-src http://nginx.org/packages/ubuntu/ precise nginx" | sudo tee -a /etc/apt/sources.list
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv ABF5BD827BD9BF62
sudo apt-get update
sudo apt-get -y install git nginx ruby1.9.1 ruby1.9.1-dev   rubygems1.9.1 irb1.9.1 ri1.9.1 rdoc1.9.1   build-essential libopenssl-ruby1.9.1 libssl-dev zlib1g-dev
sudo update-alternatives --install /usr/bin/ruby ruby /usr/bin/ruby1.9.1 400 --slave   /usr/share/man/man1/ruby.1.gz ruby.1.gz /usr/share/man/man1/ruby1.9.1.1.gz --slave   /usr/bin/ri ri /usr/bin/ri1.9.1 --slave   /usr/bin/irb irb /usr/bin/irb1.9.1 --slave   /usr/bin/rdoc rdoc /usr/bin/rdoc1.9.1
sudo update-alternatives --config ruby
sudo update-alternatives --config gem

sudo gem install nanoc adsf kramdown
sudo cp server/default.conf /etc/nginx/conf.d
sudo service nginx restart
