#!/bin/bash
#if [ -z "$1" ]; then
    #echo "Please specific a docker..."
    #exit 1
#fi

#if [ ! -d "$HOME/Docker/$1" ]; then
    #echo "Docker not exists..."
    #exit 1
#fi

#if [ -z "$2" ]; then
    #docker-compose -f $HOME/Docker/$1/docker-compose.yml up -d
#else
    #docker-compose -f $HOME/Docker/$1/docker-compose.yml $2
#fi

ACTIONS="build bundle config create down events exec help images kill logs pause port ps pull push restar rm run scale start stop top unpaus up versio"


if [ $# -eq 0 ]; then
    echo "Please specific a docker..."
    exit 1
fi

if echo "$ACTIONS" | grep "$1" > /dev/null; then
    for container in "${@:2}"; do
        docker-compose -f $HOME/Docker/$container/docker-compose.yml $1
    done
else
    docker-compose -f $HOME/Docker/$1/docker-compose.yml up -d
    for container in "${@:2}"; do
        docker-compose -f $HOME/Docker/$container/docker-compose.yml up -d
    done
fi
