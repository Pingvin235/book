#!/bin/bash

docker pull gitlab/gitlab-runner:latest && docker stop gitlab-runner && docker rm gitlab-runner  
docker run -d --name gitlab-runner --restart always -v /srv/gitlab-runner/config:/etc/gitlab-runner -v /var/run/docker.sock:/var/run/docker.sock   gitlab/gitlab-runner:latest

sleep 10s

docker pull gitlab/gitlab-ce:latest && docker stop gitlab && docker rm gitlab  
docker run -d --name gitlab --restart always --hostname git.pzdc.de --publish 8443:443 --publish 880:80 --publish 822:22 --volume /srv/gitlab/config:/etc/gitlab --volume /srv/gitlab/logs:/var/log/gitlab --volume /srv/gitlab/data:/var/opt/gitlab gitlab/gitlab-ce:latest

