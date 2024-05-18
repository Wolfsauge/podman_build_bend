# podman_build_bend

This repo contains scripts for building Docker images of HigherOrderCO's [Bend](https://github.com/HigherOrderCO/Bend/).

## Docker Image CI

The GitHubActions workflow pushes it to a [Docker Hub Container Image Library](https://hub.docker.com/repository/docker/nschle/bend/) repo.

[![Docker Image CI](https://github.com/Wolfsauge/podman_build_bend/actions/workflows/docker-image.yaml/badge.svg)](https://github.com/Wolfsauge/podman_build_bend/actions/workflows/docker-image.yaml)

## Example run

```shell
$ podman run \
    --replace \
    --device nvidia.com/gpu=all \
    --name=bend \
    --ipc=host \
    -dit \
    docker.io/nschle/bend:gha-latest
```
