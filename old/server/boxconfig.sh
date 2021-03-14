#!/bin/bash
sudo apt-get update
sudo apt-get -y install git ruby ruby-dev rubygems build-essential
sudo gem install nanoc
sudo gem install adsf
sudo gem install kramdown
sudo gem install nanoc-cachebuster