#!/bin/bash
function isSwarmNode() {
    if [[ "$(docker info 2>/dev/null | grep Swarm | sed 's/Swarm: //g' | xargs echo -n)" == "active" ]]; then
        echo true;
    else
        echo false;
    fi
}

function isDockerInstalled() {
    which docker &> /dev/null
    local result="$?"
    if [[ "${result}" -eq 0 ]]; then
        echo true;
    else
        echo false;
    fi
}

function readServerVersion() {
    echo $(cat ./server.version)
}

if [[ "$(isDockerInstalled)" == "false" ]]; then
    echo "Docker is not installed."
    exit 1
fi

if [[ "$(isSwarmNode)" == "false" ]]; then
    echo "Docker is not in Swarm mode. Use 'docker swarm init' command."
    exit 2
fi

echo "Docker is installed with Swarm mode enabled. Proceeding with Habit installation."

VERSION=$(readServerVersion)
[ -z "$SERVER_IMAGE" ] && export SERVER_IMAGE="ghcr.io/wttech/habit/habit-server:${VERSION}"

export HABIT_HTTP_PORT=7080

docker stack deploy -c ./docker-compose.yml habit

dockerResult=$?

if [[ "${dockerResult}" -ne 0 ]]; then
    echo "Installation failed."
    exit 3
fi
