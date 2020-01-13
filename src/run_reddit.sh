#!/usr/bin/env bash

docker run -d --network=reddit --network-alias=post_db --network-alias=comment_db -v reddit_db:/data/db  mongo:latest
docker run -d --network=reddit --network-alias=post trimon90/post:1.0
docker run -d --network=reddit --network-alias=comment trimon90/comment:1.0
docker run -d --network=reddit -p 9292:9292 trimon90/ui:2.0

APP_IP=`docker-machine ip docker-host`

python -m webbrowser -t http://$APP_IP:9292/new
