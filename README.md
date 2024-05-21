# podman_build_bend

This repo contains scripts for building Docker images of HigherOrderCO's [Bend](https://github.com/HigherOrderCO/Bend/).

## Docker Image Tags

* `docker pull nschle/bend:archlinux`
    * nvcc is provided in the image
    * big image: ~ 8 GB compressed
    * single stage build
    * based on [Arch Linux](https://hub.docker.com/_/archlinux/)
* `docker pull nschle/bend:ubuntu-22.04`
    * nvcc is _not_ provided in the image
    * small image: ~ 3 GB compressed
    * 2-stage build: bend is built with the devel image, then copied to the runtime image
    * based on [Nvidia CUDA Ubuntu 22.04](https://hub.docker.com/r/nvidia/cuda)

Both images contain a CUDA 12.4 runtime, SBOM and provenance attestation manifests for all stages.

## Docker Image CI

[![Arch Docker Image CI](https://github.com/Wolfsauge/podman_build_bend/actions/workflows/arch-docker-image.yaml/badge.svg)](https://github.com/Wolfsauge/podman_build_bend/actions/workflows/arch-docker-image.yaml)
[![Ubuntu 22.04 Docker Image CI](https://github.com/Wolfsauge/podman_build_bend/actions/workflows/ubuntu-docker-image.yaml/badge.svg)](https://github.com/Wolfsauge/podman_build_bend/actions/workflows/ubuntu-docker-image.yaml)

## Docker Hub Container Image Library

* [Docker Hub Container Image Library](https://hub.docker.com/repository/docker/nschle/bend/)

## Example run

Insert your preferred TAG from above.

```shell
$ podman run \
    --replace \
    --device nvidia.com/gpu=all \
    --name=bend \
    --ipc=host \
    -dit \
    docker.io/nschle/bend:TAG
```
