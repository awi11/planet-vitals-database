#!/bin/bash

running_ctnrs=$(docker ps -q)
if [ -n "${running_ctnrs}" ]; then
    docker kill $running_ctnrs
fi

stopped_ctnrs=$(docker ps -aq)
if [ -n "${stopped_ctnrs}" ]; then
    docker rm $stopped_ctnrs
fi

imgs=$(docker images -q)
if [ -n "${imgs}" ]; then
    docker rmi $imgs
fi
