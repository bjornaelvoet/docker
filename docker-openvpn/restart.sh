#!/bin/zsh

source env.sh

# run down
docker-compose down

# run up daemonized
docker-compose up -d
