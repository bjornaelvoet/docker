#!/bin/zsh

# Add ENVIRONMENT=test or ENVIRONMENT=prod before the script. If nothing given defaulting to prod.
if [[ ! -v ENVIRONMENT ]];
then
  ENVIRONMENT=prod
fi
export ENVIRONMENT

# Export default user id and groupid
if [[ ! -v UID ]];
then
  UID=$(id -u)
fi
export UID

# Export default user id and groupid
if [[ ! -v GID ]];
then
  GID=$(id -g)
fi
export GID

# run build
docker-compose -f docker-compose-openhab.yml logs
docker-compose -f docker-compose-suite.yml logs
