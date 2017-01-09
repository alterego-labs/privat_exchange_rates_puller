#!/bin/bash

PWD=$(pwd)

function stop_container_by_name {
  pid=`docker ps -a | grep "$1" | cut -d " " -f 1`;
  if [ -n "$pid" ];
  then
    echo "Stopping $1 container..."
    docker rm -f $pid > /dev/null;
  fi
}

function build_app_container {
  echo "Building app container..."
  source $PWD/docker/envs
  docker build \
    --build-arg TARGET_CCY=$TARGET_CCY \
    --build-arg PRIVAT_CLIENT_ID=$PRIVAT_CLIENT_ID \
    --build-arg PRIVAT_CLIENT_SECRET=$PRIVAT_CLIENT_SECRET \
    --build-arg SLACK_NOTIFICATION_HOOK_URL=$SLACK_NOTIFICATION_HOOK_URL \
    -t pcp_image .
}

function run_app_container {
  echo "Running app container..."
  docker run \
    --name pcp_container \
    -d -i pcp_image
}

function stop_app_container {
  echo "Stopping app container..."
  stop_container_by_name "pcp_container";
}

function run_mix_command {
  echo "Running mix command '$1' on app container..."
  docker run \
    --rm \
    --env-file $PWD/docker/envs \
    pcp_image $1
}

case "$1" in
  "setup")
    cp $PWD/docker/envs.example $PWD/docker/envs;;
  "build")
    build_app_container;;
  "run")
    run_app_container;;
  "stop")
    stop_app_container;;
  "run_custom_mix")
    run_mix_command "mix $2";;
esac
