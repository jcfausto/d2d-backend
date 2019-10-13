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
  heroku config:set REACT_APP_LOCATION_API_URL=https://d2d-backend-api.herokuapp.com/api/v1/config
  heroku config:set REACT_APP_STREAMING_API_URL=wss://d2d-backend-streaming-server.herokuapp.com
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
