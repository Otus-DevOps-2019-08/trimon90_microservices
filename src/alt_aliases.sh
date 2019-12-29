#!/usr/bin/env bash

docker run -d --network=reddit --network-alias=post_db2 --network-alias=comment_db2 mongo:latest
docker run -d --network=reddit --network-alias=post2 --env POST_DATABASE_HOST=post_db2  trimon90/post:1.0
docker run -d --network=reddit --network-alias=comment2 --env COMMENT_DATABASE=comment_db2 trimon90/comment:1.0
docker run -d --network=reddit -p 9292:9292 --env POST_SERVICE_HOST=post2 --env COMMENT_SERVICE_HOST=comment2 trimon90/ui:1.0

APP_IP=`docker-machine ip docker-host`

python -m webbrowser -t http://$APP_IP:9292
