#!/bin/bash

exec 1>/var/lib/cloud/stdout.txt
exec 2>/var/lib/cloud/stderr.txt

set -o xtrace
set -e

sudo amazon-linux-extras install docker

sudo service docker start

sudo usermod -a -G docker ec2-user

sudo chkconfig docker on

sudo yum install -y git

sudo curl -L https://github.com/docker/compose/releases/download/1.22.0/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose

sudo chmod +x /usr/local/bin/docker-compose

sudo chmod 666 /var/run/docker.sock

docker run -dtih gosite --name gosite -p 80:8080 smarman/gosite:0.0.7