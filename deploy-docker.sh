#!/bin/bash

function throw_error_if_need() {
    if [ $? -ne 0 ]; then
        echo "An error ocurred"
        exit 1
    fi
}

echo "Running Docker container..."

container_name=${1:-"csharp_microservice_container"}
image_name=${2:-"csharp_microservice_image"}
image_tag=${3:-"v1.0.0"}
port=${4:-"32001"}
env_var_default=${5:-"hml"}

docker container stop $container_name
docker container rm $container_name

docker run -d \
    -e CSHARP_MICROSERVICE_SYS_ENV=$env_var_default \
    -p $port:5074 \
    --name $container_name \
    $image_name:$image_tag \
    sh -c "dotnet Main/Apps/Api/bin/Release/net8.0/Api.dll"
throw_error_if_need

timeout_sec=15
counter=0
while [ $(docker container inspect -f '{{.State.Running}}' $container_name) != "true" ]; do
    echo "Waiting for container to be ready..."
    sleep 1
    counter=$((counter+1))
    if [ $counter -eq $timeout_sec ]; then
        echo "Timeout reached"
        exit 1
    fi
done
