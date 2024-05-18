# podman_build_bend

This repo contains scripts for building [Bend](https://github.com/HigherOrderCO/Bend/).

## Example run

```shell
$ podman run \
    --replace \
    --device nvidia.com/gpu=all \
    --name=bend \
    --ipc=host \
    -dit \
    localhost/podman_build_bend_bend:latest
```
