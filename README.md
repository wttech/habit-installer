# Habit installer

## Prerequisites

### Docker

### Docker Swarm

Once Docker is ready you have to initialize the Swarm mode.

Execute `docker swarm init`

If you encounter message displayed below then your Docker is already in Swarm mode and you don't have to do anything.

```
Error response from daemon: This node is already part of a swarm. Use "docker swarm leave" to leave this swarm and join another one.
```

## Installing

`sh install.sh`

## Upgrading

Uninstall Habit. Wait a few seconds and install the new version.

## Uninstalling

`sh uninstall.sh`