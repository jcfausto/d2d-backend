#!/bin/bash

if [ -z "$1" ]
  then
    echo "Please provide one of the following arguments: web, api, or streaming"
    echo "Example: ./deploy-heroku api"
    exit 1
fi

cp Dockerfile-$1 Dockerfile

if [ $1 = "web" ]; then
  heroku git:remote -a d2d-dashboard
fi

if [ $1 = "api" ]; then
  heroku git:remote -a d2d-backend-api
fi

if [ $1 = "streaming" ]; then
  heroku git:remote -a d2d-backend-streaming-server
fi

heroku container:push web
heroku container:release web

if [ $1 = "api" ]; then
  cp Dockerfile-consumers Dockerfile
  heroku container:push consumers
  heroku container:release consumers
fi

rm -rf Dockerfile
