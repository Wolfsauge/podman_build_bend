# podman_build_bend

This repo contains scripts for building HigherOrderCO's [Bend](https://github.com/HigherOrderCO/Bend/). The GitHubActions workflow pushes it to a [Docker Hub Container Image Library](https://hub.docker.com/repository/docker/nschle/bend/) repo.

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
