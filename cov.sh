#!/bin/sh

set -xe

CWD=$(pwd $(dirname $0))
COV=${CWD}/coverage

rake cov

docker run -it --rm \
  -v ${COV}:/usr/share/nginx/html:ro \
  -p 8080:80 \
  nginx
