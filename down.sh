#!/bin/bash
set -o errexit
set -o pipefail
set -o nounset

source docker-linux-env.sh
docker-compose down

source docker-windows-env.sh
docker-compose down

