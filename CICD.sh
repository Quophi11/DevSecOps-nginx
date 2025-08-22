#!/bin/bash
set -e

APP_NAME=mywebapp
VERSION=INSECURE

#BUILD: Clenaup old container/build image
docker rm -f $APP_NAME 2>/dev/null || true
docker build -t $APP_NAME:$VERSION . 
docker scout cves $APP_NAME:$VERSION --output ./vulnerability_report
docker scout cves $APP_NAME:$VERSION --only-severity critical,high --exit-code

#TEST: Run the container
docker run -d -p 80:80 --name webapp $APP_NAME:$VERSION

