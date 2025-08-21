#!/bin/bash
set -e

APP_NAME=mywebapp
VERSION=INSECURE

#BUILD: Clenaup old container/build image
docker rm -f $APP_NAME 2>/dev/null || true
docker build -t $APP_NAME:$VERSION . 
docker scout cves mywebapp:INSECURE --output ./vulns.report
docker scout cves mywebapp:INSECURE --only-severity high --exit-code
#TEST: Run the container
docker run -d -p 80:80 --name $APP_NAME:$VERSION webapp


