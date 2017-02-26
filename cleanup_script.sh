#!/bin/bash
mkdir /var/lib/apt/lists
mkdir /var/cache/apt/archives/
apt-get autoremove
rm -rf /home/android/.ssh/authorized_keys