#!/bin/bash
set -o errexit
set -o pipefail
set -o nounset

mkdir -p secrets
if ! [ -f secrets/session_signing_key ]; then
  ssh-keygen -t rsa -P "" -f secrets/session_signing_key
fi

if ! [ -f secrets/tsa_host_key ]; then
  ssh-keygen -t rsa -P "" -f secrets/tsa_host_key
fi

if ! [ -f secrets/worker_key ]; then
  ssh-keygen -t rsa -P "" -f secrets/worker_key
fi

if ! which docker-compose; then
  sudo wget "https://github.com/docker/compose/releases/download/1.24.1/docker-compose-$(uname -s)-$(uname -m)" -O /usr/local/bin/docker-compose 
  sudo chmod +x /usr/local/bin/docker-compose
fi

source docker-linux-env.sh
docker-compose up --detach --build concourse-web concourse-linux-worker

source docker-windows-env.sh
docker-compose up --detach --build concourse-windows-worker

sleep 5

fly -t test login -u test -p test -c http://192.168.175.10:8080/

fly -t test set-pipeline -p hello-world -c hello-world-pipeline.yml --non-interactive

fly -t test unpause-pipeline -p hello-world

fly -t test trigger-job -j hello-world/job-hello-world-linux --watch

fly -t test trigger-job -j hello-world/job-hello-world-windows --watch